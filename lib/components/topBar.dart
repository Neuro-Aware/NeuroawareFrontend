import 'package:flutter/material.dart';
import 'package:neuroaware/components/shimmerLoading.dart';

class TopBar extends StatelessWidget {
  TopBar(
      {Key? key,
      this.greetingView = false,
      this.greeting = '',
      this.name = '',
      this.title = '',
      this.loading = false})
      : super(key: key);

  String title;
  bool greetingView = false;
  String greeting;
  String name;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 30, 12, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            loading
                ? // create a gradient animated shimmer effect for loading
                ShimmerLoading(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.025,
                  )
                : Text(title,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    )),
            greetingView
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(greeting,
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w600)),
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                : Text('')
          ],
        ),
      ),
    );
  }
}
