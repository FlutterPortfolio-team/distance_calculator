import 'package:distance_calculator/screens/home_screen.dart';
import 'package:distance_calculator/screens/sign_in.dart';
import 'package:flutter/material.dart';

import 'screens/mapView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Distance-Caclculator',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      home: const Scaffold(body: MapView()),
    );
  }
}
