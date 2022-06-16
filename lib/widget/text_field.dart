import 'package:flutter/material.dart';

class textInput extends StatelessWidget {
 final Function(String) locationCallback;
 TextEditingController controller;
 String label;
 FocusNode focusNode;
 String hint;
 double width;
 Icon prefixIcon;
 Widget? suffixIcon;

textInput(
  {Key? key,   
  required this.locationCallback,
  required this.hint,
  required this.label,
  required this.prefixIcon,
  this.suffixIcon,
  required this.focusNode,
  required this.width,
  required this.controller


 }) 
 : super(key: key);

   

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width*0.8,
      child:  TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder:  OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2
            ),),
          focusedBorder: OutlineInputBorder(
            borderRadius:const BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.all(15),
          hintText: hint,  
        ),
      ),
    );
  }
}