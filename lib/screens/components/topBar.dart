import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  TopBar(
      {Key? key,
      required this.greeting,
      required this.name,
      required this.greeting_view,
      required this.title})
      : super(key: key);

  String title;
  bool greeting_view = false;
  String greeting;
  String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
            )),
        greeting_view
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(greeting,
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                  Text(
                    name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  )
                ],
              )
            : Text('')
      ],
    );
  }
}
