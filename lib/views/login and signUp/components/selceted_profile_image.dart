import 'dart:io';

import 'package:flutter/material.dart';

class SelectedProfileImage extends StatelessWidget {
  const SelectedProfileImage({super.key, required this.image});
  final File image;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final radius = size > 600 ? 70.0 : 50.0; // tablet vs phone
   
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white24,
      backgroundImage: FileImage(image),
    );
  }
}
