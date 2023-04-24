import 'package:flutter/material.dart';

class showMenuButton extends StatelessWidget {
  VoidCallback onTap;
  showMenuButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 100,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.only(right: 40),
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.category,
            color: Colors.yellow.shade100,
          ),
        ),
      ),
    );
  }
}
