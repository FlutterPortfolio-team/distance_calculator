import 'dart:async';

import 'package:distance_calculator/services/authentication.dart';
import 'package:distance_calculator/utils/show_snackb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helpers/router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  String password = '';
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isEmailVerified = false;
  // bool canResendEmail = false;
  Timer? timer;

  Widget _buildFullNameTS() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Full Name',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 17.0),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: Offset(2, 2),
                )
              ]),
          height: 60.0,
          child: TextField(
            style: TextStyle(
              color: Colors.black45,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.blue.shade400,
              ),
              hintText: 'Enter your Name',
              hintStyle: TextStyle(
                color: Colors.black45,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNoTS() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Phone No',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 17.0),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: Offset(2, 2),
                )
              ]),
          height: 60.0,
          child: TextField(
            style: TextStyle(
              color: Colors.black45,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.blue.shade400,
              ),
              hintText: 'Enter your Phone no',
              hintStyle: TextStyle(
                color: Colors.black45,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTS() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 17.0),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: Offset(2, 2),
                )
              ]),
          height: 60.0,
          child: TextField(
            controller: emailController,
            style: TextStyle(
              color: Colors.black45,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.blue.shade400,
              ),
              hintText: 'Enter your Email',
              hintStyle: TextStyle(
                color: Colors.black45,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTS() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 17.0),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: Offset(2, 2),
                )
              ]),
          height: 60.0,
          child: TextFormField(
            controller: passwordController,
            validator: (value) {
              password = value!;
              if (value.isEmpty) {
                return "Please Enter New Password";
              } else if (value.length < 8) {
                return "Password must be atleast 8 characters long";
              } else {
                return null;
              }
            },
            onChanged: ((value) => password = value),
            style: TextStyle(
              color: Colors.black45,
            ),
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.blue.shade400,
              ),
              hintText: 'Enter your Password',
              hintStyle: TextStyle(
                color: Colors.black45,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordTS() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Confirm Password',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 17.0),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: Offset(2, 2),
                )
              ]),
          height: 60.0,
          child: TextFormField(
            controller: confirmPasswordController,
            style: TextStyle(
              color: Colors.black45,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Re-Enter New Password";
              } else if (value.length < 8) {
                return "Password must be atleast 8 characters long";
              } else if (value != passwordController.text.toString()) {
                passwordController.clear();
                confirmPasswordController.clear();
                return "Password must be same as above";
              } else {
                return null;
              }
            },
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.blue.shade400,
              ),
              hintText: 'Confirm Password',
              hintStyle: TextStyle(
                color: Colors.black45,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(5.0),
            padding: MaterialStateProperty.all(const EdgeInsets.all(15.0)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
            backgroundColor: MaterialStateProperty.all(Colors.blue.shade400)),
        onPressed: (() {
          FocusScope.of(context).unfocus();

          if (confirmPasswordController.text.toString() !=
              passwordController.text.toString()) {
            showSnackBar(context, "Password must be same as above");
            passwordController.clear();
            confirmPasswordController.clear();
            // return "Password must be same as above";
          } else {
            Auth(FirebaseAuth.instance).signUpWithEmailAndPassword(
                email: emailController.text.trim(),
                password: confirmPasswordController.text.trim(),
                context: context);
          }
          Navigator.of(context).pushNamed(Routes.loginRoute);
        }),
        child: const Text(
          'REGISTER',
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSignInBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.loginRoute);
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Have an Account?',
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: ' Sign In',
                style: TextStyle(
                  color: Colors.blue.shade500,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Stack(children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 40.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _buildFullNameTS(),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _buildPhoneNoTS(),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _buildEmailTS(),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _buildPasswordTS(),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _buildConfirmPasswordTS(),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _buildRegisterBtn(),
                    const SizedBox(
                      height: 40,
                    ),
                    _buildSignInBtn()
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
