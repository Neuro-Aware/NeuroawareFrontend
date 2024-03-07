// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  bool loading;
  Color color;
  double radius;
  double textsize;

  SubmitButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.loading = false,
      this.color = const Color.fromRGBO(40, 65, 98, 1),
      this.radius = 10,
      this.textsize = 15})
      : super(key: key);

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
                  borderRadius: BorderRadius.circular(radius)),
              backgroundColor: color),
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
                  style: TextStyle(color: Colors.white, fontSize: textsize),
                )),
    );
  }
}
