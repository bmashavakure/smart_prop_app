import 'package:flutter/material.dart';
import 'package:smart_prop_app/logic/blocs/auth_bloc/auth_event.dart';
import 'package:smart_prop_app/ui/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prop_app/core/utils/snackbar_helper.dart';
import 'package:smart_prop_app/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:smart_prop_app/logic/blocs/auth_bloc/auth_state.dart';
import 'package:smart_prop_app/ui/property/preferences.dart';

import 'login.dart';



class Register extends StatefulWidget{
  Register({super.key});

  @override
  State<Register> createState () => _RegisterState();
}


class _RegisterState extends State<Register>{
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool _isPasswordVisible = false;
  bool  _isConfirmPasswordVisible = false;

  bool confirmPassword(){
    if(passwordController.text == confirmController.text){
      return true;
    }else{
      return false;
    }
  }

  void dispose(){
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  registerUser(){
    if(confirmPassword()){
      context.read<AuthBloc>().add(AuthRegisterEvent(name: nameController.text, email: emailController.text, password: passwordController.text));
    }else{
      SnackBarHelper.showWarningSnackBar("Passwords Do Not Match");
    }
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state){
          if(state is AuthAuthenticated){
            SnackBarHelper.showSuccessSnackBar(state.message);
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => Preference()));
          }else if(state is AuthError){
            SnackBarHelper.showErrorSnackBar(state.error);
          }else{
            SnackBarHelper.showErrorSnackBar("Something Went Wrong");
          }
        },
        builder: (context, state){
          return Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Text(
                            'Welcome To SmartProp',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        SizedBox(height: 5,),

                        Center(
                          child: Text(
                            'Create Account To Get Started',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),


                    SizedBox(height: 20,),

                    Column(
                      children: [
                        TextField(
                          controller: nameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            // floatingLabelStyle: TextStyle(color: AppTheme.primaryLight),
                            focusedBorder: OutlineInputBorder(
                              // borderSide: BorderSide(
                              //   color: AppTheme.primaryLight,
                              // )
                            ),
                            suffixIcon: Icon(Icons.person, color: Colors.grey,),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13)
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),


                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            // floatingLabelStyle: TextStyle(color: AppTheme.primaryLight),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13)
                            ),
                            focusedBorder: OutlineInputBorder(
                              // borderSide: BorderSide(
                              //   color: AppTheme.primaryLight,
                              // )
                            ),
                            suffixIcon: Icon(Icons.email, color: Colors.grey,),
                          ),
                        ),

                        SizedBox(height: 10,),

                        TextField(
                          controller: passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            // floatingLabelStyle: TextStyle(color: AppTheme.primaryLight),
                            focusedBorder: OutlineInputBorder(
                              // borderSide: BorderSide(
                              //   color: AppTheme.primaryLight,
                              // )
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13)
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),

                        TextField(
                          controller: confirmController,
                          obscureText: !_isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            // floatingLabelStyle: TextStyle(color: AppTheme.primaryLight),
                            focusedBorder: OutlineInputBorder(
                              // borderSide: BorderSide(
                              //   color: AppTheme.primaryLight,
                              // )
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13)
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),

                        ElevatedButton(
                          child: (state is AuthLoading) ? Center(child: CircularProgressIndicator(),): Text('Sign Up',  style: TextStyle(fontSize: 20, color: Colors.white),),
                          onPressed: (state is AuthLoading) ? null : registerUser,
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              minimumSize: Size(300, 70),
                              // backgroundColor: AppTheme.primaryLight,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              )
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?'),

                        SizedBox(width: 5,),

                        GestureDetector(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => Login())),
                            child: Text('Sign In', style: TextStyle(),)
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}