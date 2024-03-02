// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  bool loading;

  SubmitButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: OutlinedButton(
          //create onPressed function to navigation to login page after successful registration
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Color.fromRGBO(40, 65, 98, 1)),
          child: loading
              ? SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeCap: StrokeCap.round,
                    strokeWidth: 3.0,
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )),
    );
  }
}
