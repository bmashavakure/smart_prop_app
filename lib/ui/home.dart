import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_bloc.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_event.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_state.dart';
import 'package:smart_prop_app/data/models/response_objects/property_response.dart';
import 'package:smart_prop_app/ui/components/nav_bar.dart';
import 'package:smart_prop_app/ui/property/components/property_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Property>? _allProperties;
  List<Property>? _filteredProperties;

  @override
  void initState() {
    super.initState();
    context.read<PropertyBloc>().add(LoadPropertyEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProperties(String query) {
    if (_allProperties == null) return;

    setState(() {
      if (query.isEmpty) {
        _filteredProperties = _allProperties;
      } else {
        _filteredProperties = _allProperties!.where((property) {
          final address = property.address?.toLowerCase() ?? '';
          final searchLower = query.toLowerCase();

          return address.contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Prop'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: NavBar(),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by location...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _filterProperties('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              onChanged: _filterProperties,
            ),
          ),

          // Properties List
          Expanded(
            child: BlocBuilder<PropertyBloc, PropertyState>(
              builder: (context, state) {
                // Show loading indicator while properties are being fetched
                if (state is PropertyLoading || (_allProperties == null && state is! PropertyError)) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PropertiesLoaded) {
                  // Update the properties list
                  if (_allProperties != state.properties) {
                    _allProperties = state.properties;
                    _filteredProperties = state.properties;
                  }

                  // Show empty state if no properties
                  if (_filteredProperties == null || _filteredProperties!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home_outlined,
                            size: 80,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            _searchController.text.isEmpty
                                ? 'No properties available'
                                : 'No properties found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            TextButton(
                              onPressed: () {
                                _searchController.clear();
                                _filterProperties('');
                              },
                              child: Text('Clear Search'),
                            ),
                        ],
                      ),
                    );
                  }

                  // Display properties list
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<PropertyBloc>().add(LoadPropertyEvent());
                    },
                    child: ListView.builder(
                      itemCount: _filteredProperties!.length,
                      itemBuilder: (context, index) {
                        return PropertyWidget(
                          prop: _filteredProperties![index],
                        );
                      },
                    ),
                  );
                } else if (state is PropertyError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 80,
                          color: Colors.red,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Error loading properties',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          state.error,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<PropertyBloc>().add(LoadPropertyEvent());
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                // Initial state
                return Center(
                  child: Text(
                    'Loading properties...',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
