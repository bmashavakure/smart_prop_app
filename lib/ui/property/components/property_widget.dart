import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_prop_app/core/utils/snackbar_helper.dart';
import 'package:smart_prop_app/core/utils/secure_storage_string.dart';
import 'package:smart_prop_app/data/models/booking_model.dart';
import 'package:smart_prop_app/data/models/response_objects/property_response.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_bloc.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_event.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_state.dart';
import 'package:smart_prop_app/core/theme/app_theme.dart';
import 'package:smart_prop_app/ui/property/bookings.dart';


class PropertyWidget extends StatefulWidget {
  final Property prop;
  
  PropertyWidget({super.key, required this.prop});

  @override
  State<PropertyWidget> createState() => _PropertyWidgetState();
}

class _PropertyWidgetState extends State<PropertyWidget> {
  bool _isAmenitiesExpanded = false;
  final secureStorageInstance = SecureStorageStrings();

  late List<String> imageUrls;

  @override
  void initState() {
    super.initState();
    try {
      imageUrls = List<String>.from(jsonDecode(widget.prop.imageUrls ?? "[]"));
    } catch (e) {
      imageUrls = [];
    }
  }

  void _showBookingDialog(BuildContext context) {
    DateTime? bookingDate;
    TimeOfDay? bookingTime;
    DateTime? checkoutDate;
    TimeOfDay? checkoutTime;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text('Book Property'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Booking Date'),
                    subtitle: Text(
                      bookingDate != null
                          ? DateFormat('yyyy-MM-dd').format(bookingDate!)
                          : 'Select date',
                    ),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (picked != null) {
                        setDialogState(() {
                          bookingDate = picked;
                        });
                      }
                    },
                  ),
                  
                  ListTile(
                    title: Text('Booking Time'),
                    subtitle: Text(
                      bookingTime != null
                          ? '${bookingTime!.hour.toString().padLeft(2, '0')}:${bookingTime!.minute.toString().padLeft(2, '0')}'
                          : 'Select time',
                    ),
                    trailing: Icon(Icons.access_time),
                    onTap: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setDialogState(() {
                          bookingTime = picked;
                        });
                      }
                    },
                  ),

                  Divider(),

                  ListTile(
                    title: Text('Checkout Date'),
                    subtitle: Text(
                      checkoutDate != null
                          ? DateFormat('yyyy-MM-dd').format(checkoutDate!)
                          : 'Select date',
                    ),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: bookingDate ?? DateTime.now(),
                        firstDate: bookingDate ?? DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (picked != null) {
                        setDialogState(() {
                          checkoutDate = picked;
                        });
                      }
                    },
                  ),

                  ListTile(
                    title: Text('Checkout Time'),
                    subtitle: Text(
                      checkoutTime != null
                          ? '${checkoutTime!.hour.toString().padLeft(2, '0')}:${checkoutTime!.minute.toString().padLeft(2, '0')}'
                          : 'Select time',
                    ),
                    trailing: Icon(Icons.access_time),
                    onTap: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setDialogState(() {
                          checkoutTime = picked;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (bookingDate == null || bookingTime == null ||
                      checkoutDate == null || checkoutTime == null) {
                    SnackBarHelper.showWarningSnackBar(
                        'Please select all booking details');
                    return;
                  }

                  String userId = await secureStorageInstance.readUserId();
                  int? userIdInt = int.tryParse(userId);

                  BookingModel bookingModel = BookingModel(
                    userID: userIdInt,
                    propertyID: widget.prop.id,
                    bookingDate: DateFormat('yyyy-MM-dd').format(bookingDate!),
                    bookingTime:
                        '${bookingTime!.hour.toString().padLeft(2, '0')}:${bookingTime!.minute.toString().padLeft(2, '0')}',
                    checkoutDate: DateFormat('yyyy-MM-dd').format(checkoutDate!),
                    checkoutTime:
                        '${checkoutTime!.hour.toString().padLeft(2, '0')}:${checkoutTime!.minute.toString().padLeft(2, '0')}',
                  );

                  context.read<PropertyBloc>().add(
                      BookingCreateEvent(reqObject: bookingModel));
                  Navigator.pop(dialogContext);
                },
                child: Text('Confirm Booking'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 30),
          ],
        ),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const BookingsPage()),
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertyBloc, PropertyState>(
      listener: (context, state) {
        if (state is BookingCreated) {
          _showSuccessDialog(context, state.message);
        } else if (state is PropertyError) {
          SnackBarHelper.showErrorSnackBar(state.error);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(13),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(13),
                    ),
                    child: imageUrls.isNotEmpty
                        ? Image.network(
                            imageUrls[0],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 200,
                                width: double.infinity,
                                color: Colors.grey[300],
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                  color: Colors.grey[600],
                                ),
                              );
                            },
                          )
                        : Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.home,
                              size: 50,
                              color: Colors.grey[600],
                            ),
                          ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.prop.title ?? 'No Title',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.attach_money, size: 18, color: Colors.green),
                                Text(
                                  '${widget.prop.price ?? 0}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  ' ${widget.prop.currency?.toString().split('.').last ?? ''}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),

                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.location_on, size: 16, color: Colors.red),
                                  SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      widget.prop.address ?? 'Unknown',
                                      style: TextStyle(fontSize: 14),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 8),

                        Row(
                          children: [
                            Icon(Icons.bed, size: 16),
                            SizedBox(width: 4),
                            Text('${widget.prop.bedrooms ?? 0} beds'),
                            SizedBox(width: 16),
                            Icon(Icons.bathtub, size: 16),
                            SizedBox(width: 4),
                            Text('${widget.prop.bathrooms ?? 0} baths'),
                            SizedBox(width: 16),
                            Icon(Icons.square_foot, size: 16),
                            SizedBox(width: 4),
                            Text('${widget.prop.areaSqft ?? 0} sqft'),
                          ],
                        ),

                        SizedBox(height: 12),

                        if (widget.prop.amenities != null && widget.prop.amenities!.isNotEmpty)
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isAmenitiesExpanded = !_isAmenitiesExpanded;
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Amenities',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Icon(
                                          _isAmenitiesExpanded
                                              ? Icons.expand_less
                                              : Icons.expand_more,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (_isAmenitiesExpanded)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 12,
                                      right: 12,
                                      bottom: 12,
                                    ),
                                    child: Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: widget.prop.amenities!
                                          .map((amenity) => Chip(
                                                label: Text(amenity),
                                                backgroundColor: AppTheme.surfaceDeep,
                                              ))
                                          .toList(),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                        SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _showBookingDialog(context),
                            child: Text(
                              'Book',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
