import 'package:flutter/material.dart';

class FloatingIcon extends StatelessWidget {
  double iconCardSize;
  double floatingIconPositionY;
  double floatingIconPositionX;
  IconData? currentIcon;
  FloatingIcon({
    required this.floatingIconPositionX,
    required this.floatingIconPositionY,
    required this.iconCardSize,
    this.currentIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: floatingIconPositionY - (iconCardSize / 2),
      left: floatingIconPositionX - (iconCardSize / 2),
      child: Container(
        width: iconCardSize,
        height: iconCardSize,
        decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 2,
            )),
        child: Icon(
          currentIcon,
        ),
      ),
    );
  }
}
