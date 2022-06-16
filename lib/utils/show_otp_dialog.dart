import 'package:flutter/material.dart';

void showOTPDiaog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed,
}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: const Text('Enter OTP'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: codeController,
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: onPressed, child: const Text('Done'))
            ],
          ));
}
