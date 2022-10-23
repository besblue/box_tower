import 'package:flutter/material.dart';

class DiamondsBox extends StatelessWidget {
  const DiamondsBox({Key? key, required this.boxColor, required this.size}) : super(key: key);
  final Color boxColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0.8,
      alignment: Alignment.center,
      child: Container(
        height: size,
        width: size,
        margin: const EdgeInsets.symmetric(vertical: 50),
        decoration: BoxDecoration(
          color: boxColor,
          border: Border.all(color: Colors.grey, width: 1.5),
        ),
      ),
    );
  }
}
