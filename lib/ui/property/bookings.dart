import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_bloc.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_event.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_state.dart';
import 'package:smart_prop_app/data/models/response_objects/get_bookings_response.dart';
import 'package:smart_prop_app/ui/property/components/bookings_widget.dart';
import 'package:smart_prop_app/ui/components/nav_bar.dart';


class BookingsPage extends StatefulWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  List<Booking>? _bookings;

  @override
  void initState() {
    super.initState();
    context.read<PropertyBloc>().add(LoadBookingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: NavBar(),
      body: BlocBuilder<PropertyBloc, PropertyState>(
        builder: (context, state) {
          if (state is BookingsLoaded) {
            _bookings = state.bookings;
          }

          if (state is BookingCanceled) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<PropertyBloc>().add(LoadBookingsEvent());
            });
          }

          if (state is PropertyLoading && _bookings == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is PropertyError && _bookings == null) {
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
                    'Error loading bookings',
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
                      context.read<PropertyBloc>().add(LoadBookingsEvent());
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (_bookings != null && _bookings!.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<PropertyBloc>().add(LoadBookingsEvent());
              },
              child: ListView.builder(
                itemCount: _bookings!.length,
                itemBuilder: (context, index) {
                  return BookingsWidget(
                    booking: _bookings![index],
                  );
                },
              ),
            );
          }

          if (_bookings != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_busy,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No bookings yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Book a property to see it here',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

