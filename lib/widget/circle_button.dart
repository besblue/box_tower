import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton(
      {Key? key, required this.buttonColor, this.pressUp, this.pressCancel, this.pressLong})
      : super(key: key);
  final Color buttonColor;
  final Function()? pressUp;
  final Function()? pressCancel;
  final Function()? pressLong;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressUp: pressUp,
      onLongPressCancel: pressCancel,
      onLongPress: pressLong,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: buttonColor,
            border: Border.all(
              width: 1.5,
              color: Colors.grey
            ),
            shape: BoxShape.circle),
      ),
    );
  }
}
