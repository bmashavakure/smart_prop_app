import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_prop_app/core/utils/snackbar_helper.dart';
import 'package:smart_prop_app/data/models/response_objects/get_bookings_response.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_bloc.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_event.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_state.dart';


class BookingsWidget extends StatefulWidget {
  final Booking booking;

  BookingsWidget({super.key, required this.booking});

  @override
  State<BookingsWidget> createState() => _BookingsWidgetState();
}

class _BookingsWidgetState extends State<BookingsWidget> {
  bool _isDetailsExpanded = false;

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Cancel Booking'),
        content: Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<PropertyBloc>().add(
                  BookingCancelEvent(bookingID: widget.booking.id ?? 0));
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertyBloc, PropertyState>(
      listener: (context, state) {
        if (state is BookingCanceled) {
          SnackBarHelper.showSuccessSnackBar(state.message);
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
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.booking.property?.title ?? 'Property Booking',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Active',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    // Row(
                    //   children: [
                    //     Icon(Icons.location_on, size: 16, color: Colors.red),
                    //     SizedBox(width: 4),
                    //     Expanded(
                    //       child: Text(
                    //         widget.booking.property?.address ?? 'Unknown Location',
                    //         style: TextStyle(fontSize: 14),
                    //         maxLines: 1,
                    //         overflow: TextOverflow.ellipsis,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    //
                    // SizedBox(height: 8),

                    // Row(
                    //   children: [
                    //     Icon(Icons.attach_money, size: 16, color: Colors.green),
                    //     Text(
                    //       '${widget.booking.property?.price ?? 0} ${widget.booking.property?.currency ?? ''}',
                    //       style: TextStyle(
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w600,
                    //         color: Colors.green,
                    //       ),
                    //     ),
                    //     SizedBox(width: 4),
                    //     Text(
                    //       widget.booking.property?.pricePeriod ?? '',
                    //       style: TextStyle(
                    //         fontSize: 12,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    //
                    // SizedBox(height: 12),

                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 16, color: Colors.blue),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Check-in',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      widget.booking.bookingDate != null
                                          ? '${DateFormat('MMM dd, yyyy').format(widget.booking.bookingDate!)} at ${widget.booking.bookingTime ?? ''}'
                                          : 'N/A',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                              Icon(Icons.calendar_today, size: 16, color: Colors.orange),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Check-out',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      widget.booking.checkoutDate != null
                                          ? '${DateFormat('MMM dd, yyyy').format(widget.booking.checkoutDate!)} at ${widget.booking.checkoutTime ?? ''}'
                                          : 'N/A',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12),

                    if (widget.booking.property?.bedrooms != null ||
                        widget.booking.property?.bathrooms != null ||
                        widget.booking.property?.areaSqft != null)
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
                                  _isDetailsExpanded = !_isDetailsExpanded;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Property Details',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      _isDetailsExpanded
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (_isDetailsExpanded)
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  bottom: 12,
                                ),
                                child: Row(
                                  children: [
                                    if (widget.booking.property?.bedrooms != null) ...[
                                      Icon(Icons.bed, size: 16),
                                      SizedBox(width: 4),
                                      Text('${widget.booking.property!.bedrooms} beds'),
                                      SizedBox(width: 16),
                                    ],
                                    if (widget.booking.property?.bathrooms != null) ...[
                                      Icon(Icons.bathtub, size: 16),
                                      SizedBox(width: 4),
                                      Text('${widget.booking.property!.bathrooms} baths'),
                                      SizedBox(width: 16),
                                    ],
                                    if (widget.booking.property?.areaSqft != null) ...[
                                      Icon(Icons.square_foot, size: 16),
                                      SizedBox(width: 4),
                                      Text('${widget.booking.property!.areaSqft} sqft'),
                                    ],
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),

                    SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _showCancelDialog(context),
                        child: Text(
                          'Cancel Booking',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
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
            ),
          ),
        );
      },
    );
  }
}

