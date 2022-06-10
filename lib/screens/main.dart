import 'package:distance_calculator/screens/home_screen.dart';
import 'package:distance_calculator/screens/sign_in.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Distance-Caclculator',
      debugShowCheckedModeBanner: false,
      home: SigninScreen(),
    );
  }
}
