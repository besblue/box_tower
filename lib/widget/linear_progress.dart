import 'package:flutter/material.dart';

class LinearProgress extends StatefulWidget {
  const LinearProgress({
    Key? key,
  }) : super(key: key);

  @override
  State<LinearProgress> createState() => _LinearProgressState();
}

class _LinearProgressState extends State<LinearProgress> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    startAnimation();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      color: Colors.deepPurpleAccent,
      backgroundColor: Colors.white,
      value: controller.value,
    );
  }

  startAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.forward();
  }
}
