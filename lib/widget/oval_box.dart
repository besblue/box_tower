import 'package:flutter/material.dart';

class OvalBox extends StatelessWidget {
  const OvalBox({Key? key, required this.boxColor, required this.width}) : super(key: key);
  final Color boxColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 1.5),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 1.5),
      ),
    );
  }
}
