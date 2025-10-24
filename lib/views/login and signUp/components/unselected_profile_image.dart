import 'package:flutter/material.dart';

class UnselectedProfileImage extends StatelessWidget {
  const UnselectedProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final radius = size > 600 ? 70.0 : 50.0; // tablet vs phone

    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white24,
      child: Icon(Icons.person, size: radius, color: Colors.white70),
    );
  }
}
