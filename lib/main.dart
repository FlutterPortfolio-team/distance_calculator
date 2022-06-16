import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:distance_calculator/screens/home_screen.dart';
import 'package:distance_calculator/screens/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'helpers/router.dart';
import 'screens/mapView.dart';
import 'screens/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: Routes.generateRoute,
        debugShowCheckedModeBanner: false,
        // theme: ThemeData.dark(),
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: Image.asset(
              'assets/dist1.jpeg',
              height: 150.0,
              width: 150.0,
            ),
            backgroundColor: Colors.blue.shade100,
            splashTransition: SplashTransition.scaleTransition,
            pageTransitionType: PageTransitionType.leftToRight,
            splashIconSize: 390,
            nextScreen: const SigninScreen())
        //  Scaffold(body: MapView()),
        );
  }
}
