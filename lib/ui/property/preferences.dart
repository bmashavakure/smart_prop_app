import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prop_app/core/utils/snackbar_helper.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_bloc.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_state.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_event.dart';
import 'package:smart_prop_app/data/models/preference_model.dart';
import 'package:smart_prop_app/core/utils/secure_storage_string.dart';
import 'package:smart_prop_app/ui/home.dart';


class Preference extends StatefulWidget {
  Preference({super.key});

  @override
  State<Preference> createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  final budgetController = TextEditingController();
  final propertySizeController = TextEditingController();
  final locationController = TextEditingController();
  final amenityController = TextEditingController();
  final secureStorageInstance = SecureStorageStrings();

  int selectedBedrooms = 1;
  List<String> locations = [];
  List<String> amenities = [];

  @override
  void dispose() {
    budgetController.dispose();
    propertySizeController.dispose();
    locationController.dispose();
    amenityController.dispose();
    super.dispose();
  }

  void addLocation() {
    if (locationController.text.isNotEmpty) {
      setState(() {
        locations.add(locationController.text);
        locationController.clear();
      });
    }
  }

  void removeLocation(int index) {
    setState(() {
      locations.removeAt(index);
    });
  }

  void addAmenity() {
    if (amenityController.text.isNotEmpty) {
      setState(() {
        amenities.add(amenityController.text);
        amenityController.clear();
      });
    }
  }

  void removeAmenity(int index) {
    setState(() {
      amenities.removeAt(index);
    });
  }

  Future<void> submitPreferences() async {
    double? budget = double.tryParse(budgetController.text);
    double? propertySize = double.tryParse(propertySizeController.text);

    if (budget == null) {
      SnackBarHelper.showWarningSnackBar("Please enter a valid budget");
      return;
    }

    if (propertySize == null) {
      SnackBarHelper.showWarningSnackBar("Please enter a valid property size");
      return;
    }

    if (locations.isEmpty) {
      SnackBarHelper.showWarningSnackBar("Please add at least one location");
      return;
    }

    String userId = await secureStorageInstance.readUserId();
    int? userIdInt = int.tryParse(userId);

    PreferenceModel preferenceModel = PreferenceModel(
      userID: userIdInt,
      budget: budget.toString(),
      bedrooms: selectedBedrooms,
      propertySize: propertySize,
      locations: locations,
      amenities: amenities.isEmpty ? null : amenities,
    );

    context.read<PropertyBloc>().add(PreferenceSubmitEvent(reqObject: preferenceModel));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Your Preferences'),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<PropertyBloc, PropertyState>(
        listener: (context, state) {
          if (state is PreferenceSubmitted) {
            SnackBarHelper.showSuccessSnackBar(state.message);
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HomePage()));
          } else if (state is PropertyError) {
            SnackBarHelper.showErrorSnackBar(state.error);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bedrooms Selector
                Text(
                  'Bedrooms',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Container(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      int bedroomNumber = index + 1;
                      bool isSelected = selectedBedrooms == bedroomNumber;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedBedrooms = bedroomNumber;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 60,
                          decoration: BoxDecoration(
                            color: isSelected ? Theme.of(context).primaryColor : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '$bedroomNumber',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 10),

                // Budget Input
                Text(
                  'Budget',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: budgetController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          hintText: 'Enter budget',
                          suffixIcon: Icon(Icons.attach_money, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                // Property Size Input
                Text(
                  'Property Size (sqft)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: propertySizeController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          hintText: 'Enter property size',
                          suffixIcon: Icon(Icons.square_foot, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                // Locations Input
                Text(
                  'Locations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: locationController,
                        decoration: InputDecoration(
                          hintText: 'Enter location',
                          suffixIcon: Icon(Icons.location_on, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: addLocation,
                      child: Icon(Icons.add, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: locations.asMap().entries.map((entry) {
                    return Chip(
                      label: Text(entry.value),
                      deleteIcon: Icon(Icons.close, size: 18),
                      onDeleted: () => removeLocation(entry.key),
                    );
                  }).toList(),
                ),

                SizedBox(height: 10),

                // Amenities Input
                Text(
                  'Amenities',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: amenityController,
                        decoration: InputDecoration(
                          hintText: 'Enter amenity',
                          suffixIcon: Icon(Icons.apartment, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: addAmenity,
                      child: Icon(Icons.add, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: amenities.asMap().entries.map((entry) {
                    return Chip(
                      label: Text(entry.value),
                      deleteIcon: Icon(Icons.close, size: 18),
                      onDeleted: () => removeAmenity(entry.key),
                    );
                  }).toList(),
                ),

                SizedBox(height: 20),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    child: (state is PropertyLoading)
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Submit',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                    onPressed: (state is PropertyLoading) ? null : submitPreferences,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: Size(300, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}

