import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prop_app/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:smart_prop_app/logic/blocs/auth_bloc/auth_state.dart';
import 'package:smart_prop_app/logic/blocs/auth_bloc/auth_event.dart';
import 'package:smart_prop_app/core/utils/snackbar_helper.dart';
import 'package:smart_prop_app/ui/auth/login.dart';
import 'package:smart_prop_app/ui/components/nav_bar.dart';


class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  void logoutUser() {
    context.read<AuthBloc>().add(AuthLogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: NavBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            SnackBarHelper.showSuccessSnackBar("Logged out successfully");
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => Login()),
              (route) => false,
            );
          } else if (state is AuthError) {
            SnackBarHelper.showErrorSnackBar(state.error);
          }
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 100,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 60),
                  ElevatedButton(
                    child: (state is AuthLoading)
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Logout',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                    onPressed: (state is AuthLoading) ? null : logoutUser,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: Size(300, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

