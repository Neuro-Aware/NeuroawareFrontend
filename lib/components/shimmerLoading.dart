import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  ShimmerLoading({
    super.key,
    this.shape = BoxShape.rectangle,
    this.width = 0,
    this.height = 0,
  });
  BoxShape shape;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      direction: ShimmerDirection.ltr,
      gradient: LinearGradient(
        colors: [
          Colors.grey[100]!,
          Colors.grey[400]!,
          Colors.grey[100]!,
          Colors.grey[400]!,
        ],
      ),
      child: shape == BoxShape.rectangle
          ? Container(
              height: height == 0
                  ? MediaQuery.of(context).size.height * 0.025
                  : height,
              width:
                  width == 0 ? MediaQuery.of(context).size.width * 0.3 : width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[300],
              ),
            )
          : Container(
              width:
                  width == 0 ? MediaQuery.of(context).size.width * 0.3 : width,
              height: height == 0
                  ? MediaQuery.of(context).size.height * 0.025
                  : height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
            ),
    );
  }
}
