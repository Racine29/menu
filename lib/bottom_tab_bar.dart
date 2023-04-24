import 'package:flutter/material.dart';

class BottomTabBar extends StatelessWidget {
  bool isSlide;

  double translateX;

  List<IconData> icons;

  IconData newIcon;

  double tabSize;
  Function(DragUpdateDetails)? onHorizontalDragUpdate;

  BottomTabBar({
    required this.icons,
    required this.isSlide,
    required this.newIcon,
    required this.tabSize,
    required this.translateX,
    this.onHorizontalDragUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: 0,
      left: isSlide ? -translateX : 0,
      right: isSlide ? translateX : 0,
      child: GestureDetector(
        onHorizontalDragUpdate: onHorizontalDragUpdate,
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.yellow.shade50,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Row(children: [
            for (int i = 0; i < icons.length; i++) ...{
              SizedBox(
                width: tabSize,
                child: Center(
                    child: Icon(
                  icons[i],
                  color: icons[i] == newIcon ? Colors.grey : Colors.black,
                )),
              )
            }
          ]),
        ),
      ),
    );
  }
}
