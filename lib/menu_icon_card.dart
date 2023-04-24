import 'package:flutter/material.dart';

class MenuIconCard extends StatelessWidget {
  VoidCallback? onLongPress;
  bool isIconCard;
  double iconCardSize;
  IconData icon;
  MenuIconCard({
    required this.iconCardSize,
    required this.icon,
    required this.isIconCard,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(left: isIconCard ? 0 : 10),
        width: isIconCard ? 0 : iconCardSize,
        height: isIconCard ? 0 : iconCardSize,
        decoration: BoxDecoration(
          color: isIconCard ? Colors.transparent : Colors.amber.shade50,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon),
      ),
    );
  }
}
