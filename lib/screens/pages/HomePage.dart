// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 30, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          topBar(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Row topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('NeuroAware',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Good Morning!',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            Text(
              'Rishi Rahul Jain',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            )
          ],
        )
      ],
    );
  }
}
