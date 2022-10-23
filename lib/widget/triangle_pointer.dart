import 'package:flutter/material.dart';

class TrianglePointer extends CustomPainter {
  final bool left;

  TrianglePointer({required this.left});

  @override
  void paint(Canvas canvas, Size size) {
    if (left) {
      _buildLeft(canvas, size);
    } else {
      _buildRight(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  _buildLeft(Canvas canvas, Size size) {
    double w = size.width;
    double h = size.height;

    Paint paint = Paint()..color = Colors.white;

    Paint paintBorder = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    Path pathTriangle = Path()
      ..moveTo(w, h / 2)
      ..lineTo(0, 0)
      ..lineTo(0, h)
      ..close();

    canvas.drawPath(pathTriangle, paint);
    canvas.drawPath(pathTriangle, paintBorder);
  }

  _buildRight(Canvas canvas, Size size) {
    double w = size.width;
    double h = size.height;

    Paint paint = Paint()..color = Colors.white;

    Paint paintBorder = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    Path pathTriangle = Path()
      ..moveTo(0, h / 2)
      ..lineTo(w, 0)
      ..lineTo(w, h)
      ..close();

    canvas.drawPath(pathTriangle, paint);
    canvas.drawPath(pathTriangle, paintBorder);

  }
}
