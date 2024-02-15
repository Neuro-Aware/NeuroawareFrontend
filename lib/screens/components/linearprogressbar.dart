import 'package:flutter/material.dart';

class LinearProgressBar extends StatelessWidget {
  const LinearProgressBar({
    super.key,
    required this.progress,
    required this.color,
    required this.labelColor,
    required this.duration,
  });

  final double progress;
  final Color color;
  final Color labelColor;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: (progress / 100)),
      duration: Duration(seconds: duration),
      builder: (context, value, child) {
        return Stack(alignment: Alignment.centerLeft, children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.white,
                minHeight: 12,
                borderRadius: BorderRadius.circular(10),
                valueColor: AlwaysStoppedAnimation<Color>(
                  color,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 2),
            child: Text('${progress.toInt()}%',
                style: TextStyle(
                    fontSize: 13,
                    color: labelColor,
                    fontWeight: FontWeight.bold)),
          ),
        ]);
      },
    );
  }
}
