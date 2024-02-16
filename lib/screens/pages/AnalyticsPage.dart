// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:neuroaware/screens/components/circularChart.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  int _selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(60),
      //   child: TopBar(
      //     title: 'Analytics',
      //     greeting_view: false,
      //     greeting: 'Good Morning',
      //     name: 'John Doe',
      //   ),
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 30, 12, 0),
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
              SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 70,
                            padding: EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width / 3 + 10,
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Active Calories',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text(
                                  '645 Cal',
                                  style: TextStyle(
                                    fontSize: 20,
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
                            width: MediaQuery.of(context).size.width / 3 + 10,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(164, 138, 237, 0.404),
                              borderRadius: BorderRadius.circular(10),
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
                        width: MediaQuery.of(context).size.width * 2 / 3 - 44,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
