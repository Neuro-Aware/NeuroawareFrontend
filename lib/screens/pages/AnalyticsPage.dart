// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:neuroaware/components/barChart.dart';
import 'package:neuroaware/components/circularChart.dart';
import 'package:neuroaware/components/linearprogressbar.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _stepCount = 70;
  int _selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              firstColumn(context),
              SizedBox(
                height: 10,
              ),
              secondColumn(context),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 170,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 17.5,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(141, 62, 210, 0.404),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(141, 62, 210, 0.5),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Icon(LineIcons.bed,
                                        size: 21, color: Colors.black),
                                  ),
                                ),
                                Text('Sleep',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                              ],
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Container(
                                height:
                                    MediaQuery.of(context).size.height / 6 - 19,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                ),
                                child: WeekBarChart(
                                  showBottomTitles: false,
                                  showLeftTitles: false,
                                  gradient: false,
                                  barColor: Color.fromRGBO(64, 10, 110, 1),
                                  backgroundColor: Colors.transparent,
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 17.5,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(149, 204, 227, 0.404),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(135, 187, 210, 0.6),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Icon(CupertinoIcons.drop,
                                        size: 21, color: Colors.black),
                                  ),
                                ),
                                Text('Water Intake',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                              ],
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height / 6 - 19,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                    child: Lottie.network(
                                      'https://lottie.host/899f020e-7f0b-47f1-b50a-d5b80509f3af/CuCsohQavi.json',
                                      controller: _controller,
                                      // animate: true,
                                      // reverse: true,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Center(
                                    child: TweenAnimationBuilder(
                                      curve: Curves.easeOut,
                                      tween: Tween(begin: 0.0, end: 3),
                                      onEnd: () =>
                                          _controller.repeat(reverse: true),
                                      duration: Duration(seconds: 10),
                                      builder: (context, value, child) {
                                        return Text(
                                          '${value.toDouble().toStringAsFixed(1)} L',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Nunito',
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 11,
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 6),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Month year',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: dateBar(),
              ),
              Text('Today Report',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )),
            ],
          ),
        ));
  }

  Row secondColumn(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width / 2 + 10,
          decoration: BoxDecoration(
            color: Color.fromRGBO(237, 71, 71, 0.35),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(237, 71, 71, 0.6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(LineIcons.heartbeat,
                            size: 25, color: Colors.black),
                      ),
                    ),
                    Text('Heart Rate',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Container(
              height: 133,
              width: MediaQuery.of(context).size.width / 2 - 44,
              decoration: BoxDecoration(
                color: Color.fromRGBO(252, 196, 111, 0.35),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(252, 196, 111, 0.6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(LineIcons.running,
                                size: 23, color: Colors.black),
                          ),
                        ),
                        Text('Steps',
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TweenAnimationBuilder(
                      tween: IntTween(begin: 0, end: _stepCount),
                      duration: Duration(seconds: 2),
                      builder: (context, value, child) {
                        return Text(
                          '${value * 10}/1000',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    LinearProgressBar(
                      showLabel: false,
                      progress: _stepCount.toDouble(),
                      color: Color.fromRGBO(252, 196, 111, 1),
                      labelColor: Colors.black,
                      duration: 2,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 62,
              width: MediaQuery.of(context).size.width / 2 - 44,
              decoration: BoxDecoration(
                color: Color.fromRGBO(242, 70, 70, 0.605),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text('🔥 Keep it up!💪',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 0, 0, 0))),
              ),
            ),
          ],
        )
      ],
    );
  }

  Row firstColumn(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              height: 70,
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Active Calories',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(
                    '645 Cal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 140,
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                color: Color.fromRGBO(164, 138, 237, 0.404),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    'Training Time',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircularChart(
                    duration: 2,
                    height: 80,
                    width: 80,
                    perc: 80,
                    fontSize: 20,
                    startOffset: 0,
                    endOffset: 360,
                    color: Color.fromRGBO(164, 138, 237, 1),
                    backgroundcolor: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          height: 220,
          width: MediaQuery.of(context).size.width * 2 / 3 - 35,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(LineIcons.bicycle,
                            size: 30, color: Colors.black),
                      ),
                    ),
                    Text('Cycling',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 145,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  SingleChildScrollView dateBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            30,
            (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 40,
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                    child: Center(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'S',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: _selectedIndex == index
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        Text(
                          '${index + 1}',
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: _selectedIndex == index
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ],
                    )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _selectedIndex == index
                          ? Colors.black
                          : Color.fromARGB(255, 90, 224, 95),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                )),
      ),
    );
  }
}
