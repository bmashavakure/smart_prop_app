import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prop_app/core/theme/app_theme.dart';
import 'package:smart_prop_app/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:smart_prop_app/logic/blocs/property_bloc/property_bloc.dart';
import 'package:smart_prop_app/data/repository/auth_repository.dart';
import 'package:smart_prop_app/data/repository/property_repository.dart';
import 'package:smart_prop_app/ui/auth/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => AuthRepository()),
          RepositoryProvider(create: (context) => PropertyRepository())
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepo: context.read<AuthRepository>())),
              BlocProvider<PropertyBloc>(create: (context) => PropertyBloc(propertyRepo: context.read<PropertyRepository>())),
            ],
            child:  MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Smart Property App',
              darkTheme: AppTheme.darkTheme(),
              theme: AppTheme.lightTheme(),
              themeMode: ThemeMode.system,
              home: Login(),
            ),
        ),
    );
  }
}