import 'package:flutter/material.dart';
import 'package:smart_prop_app/logic/blocs/auth_bloc/auth_event.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_bloc.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_event.dart';
import 'package:smart_prop_app/ui/auth/register.dart';
import 'package:smart_prop_app/ui/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prop_app/core/utils/snackbar_helper.dart';
import 'package:smart_prop_app/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:smart_prop_app/logic/blocs/auth_bloc/auth_state.dart';



class Login extends StatefulWidget{
  Login({super.key});

  @override
  State<Login> createState () => _LoginState();
}


class _LoginState extends State<Login>{
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  bool _isPasswordVisible = false;

  void dispose(){
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  loginUser(){
    context.read<AuthBloc>().add(AuthLoginEvent(email: emailController.text, password: passwordController.text));
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state){
          if(state is AuthAuthenticated){
            SnackBarHelper.showSuccessSnackBar(state.message);
            // Load properties when user logs in
            context.read<PropertyBloc>().add(LoadPropertyEvent());
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HomePage()));
          }else if(state is AuthError){
            SnackBarHelper.showErrorSnackBar(state.error);
          }
        },
        builder: (context, state){
          return Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Text(
                            'Welcome Back To SmartProp',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        SizedBox(height: 5,),

                        Center(
                          child: Text(
                            'Login To Get Started',
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
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            // floatingLabelStyle: TextStyle(color: AppTheme.primaryLight),
                            focusedBorder: OutlineInputBorder(
                              // borderSide: BorderSide(
                              //   color: AppTheme.primaryLight,
                              // )
                            ),
                            suffixIcon: Icon(Icons.email, color: Colors.grey,),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13)
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),

                        TextField(
                          controller: passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            focusedBorder: OutlineInputBorder(
                              // borderSide: BorderSide(
                              //   color: AppTheme.primaryLight,
                              // )
                            ),
                            // floatingLabelStyle: TextStyle(color: AppTheme.primaryLight),
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

                        SizedBox(height: 20,),

                        ElevatedButton(
                          child: (state is AuthLoading) ? Center(child: CircularProgressIndicator(),): Text('Sign In',  style: TextStyle(fontSize: 20, color: Colors.white),),
                          onPressed: (state is AuthLoading) ? null : loginUser,
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

                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?'),

                        SizedBox(width: 5,),

                        GestureDetector(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => Register())),
                            child: Text('Sign Up', style: TextStyle(),)
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