import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedGradientBackground extends StatefulWidget {
  const AnimatedGradientBackground({super.key});

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState
    extends State<AnimatedGradientBackground> {
  final List<List<Color>> gradientColors = [
    [Color(0xFFFFCAB1), Color(0xFF69A2B0)],
    [Color(0xFF69A2B0), Color(0xFF7DAA92)],
    [Color(0xFF7DAA92), Color(0xFF80FFEC)],
    [Color(0xFF80FFEC), Color(0xFF659157)],
    [Color(0xFF659157), Color(0xFFA1C084)],
    [Color(0xFFA1C084), Color(0xFF7253E0)],
    [Color(0xFF7253E0), Color(0xFFFFCAB1)], // loop back to start
  ];

  int index = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 4), (Timer t) {
      setState(() {
        index = (index + 1) % gradientColors.length;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 4),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors[index],
        ),
      ),
    );
  }
}
