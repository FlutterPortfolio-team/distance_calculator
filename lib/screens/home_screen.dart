// import 'package:distance_calculator/constants.dart';
import 'package:distance_calculator/utils/networking.dart';
import 'package:distance_calculator/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final city1TextEditController = TextEditingController();
  final city2TextEditController = TextEditingController();
  late String distance;

  void getData() async {
    try {
      var data = await Networking()
          .getData(city1TextEditController.text, city2TextEditController.text);
      setState(() {
        distance = data['rows'][0]['elements'][0]['distance']['text'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueAccent,
      body: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        // We can actually use this decoration property but if it is out of design you ac remove it
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('images/city_background.jpg'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Calculate The Distance Between two Cities',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              TextField(
                controller: city1TextEditController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: kTextFieldInputDecoration1,
              ),
              TextField(
                controller: city2TextEditController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: kTextFieldInputDecoration2,
              ),
              OutlinedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  minimumSize:
                      MaterialStateProperty.all(const Size(60.0, 60.0)),
                  backgroundColor: MaterialStateProperty.all(Colors.black12),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ), // onPressed: null,
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Result'),
                    content: Text(
                        'Distance between ${city1TextEditController.text} and ${city2TextEditController.text} is $distance.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      )
                    ],
                  ),
                ),
                child: const Text(
                  'Calculate Distance',
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
