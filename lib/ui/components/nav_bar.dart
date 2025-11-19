import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_bloc.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_event.dart';
import 'package:smart_prop_app/ui/home.dart';
import 'package:smart_prop_app/ui/profile.dart';
import 'package:smart_prop_app/ui/property/bookings.dart';


class NavBar extends StatefulWidget{
  const NavBar({Key ? key}): super(key : key);

  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar>{

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context){
    return BottomNavigationBar(
      selectedItemColor: Colors.grey,
      unselectedItemColor: Colors.grey,


      currentIndex: selectedIndex,
      elevation: 1,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(selectedIndex == 0  ? Icons.home : Icons.home_rounded, ), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(selectedIndex == 1  ? Icons.event_available : Icons.event, ), label: 'Bookings'),
        BottomNavigationBarItem(icon: Icon(selectedIndex == 2  ? Icons.person_rounded : Icons.person, ), label: 'Profile'),
      ],
      onTap: (int index) async{
        setState(() {
          selectedIndex = index;
        });

        switch(index){
          case 0:
            context.read<PropertyBloc>().add(LoadPropertyEvent());
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()),);
            break;
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const BookingsPage()),);
            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()),);
            break;
        }

      },
    );
  }
}