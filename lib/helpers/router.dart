import 'package:distance_calculator/screens/map.dart';
import 'package:distance_calculator/screens/sign_in.dart';
import 'package:distance_calculator/screens/signup.dart';
import 'package:flutter/material.dart';



class Routes {
  static const loginRoute = 'login';
  static const signUpRoute = 'signUp';
  static const String homeRoute = 'MapView';
 
  static Route<dynamic>? generateRoute(RouteSettings settings){
  switch (settings.name) {
    case loginRoute:
    return MaterialPageRoute(builder: (context)=> const SigninScreen());
    case signUpRoute: 
    return MaterialPageRoute(builder: (context) => const SignupScreen());
    case homeRoute: 
   return MaterialPageRoute(builder: (context)=>  MapView());
    default:
         return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );

  }
}

}