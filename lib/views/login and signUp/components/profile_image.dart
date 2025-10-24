import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo_app/views/login%20and%20signUp/components/selceted_profile_image.dart';
import 'package:todo_app/views/login%20and%20signUp/components/unselected_profile_image.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, this.isImageSelected = false, this.image});

  final bool isImageSelected;
  final File? image;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) {
        // Smooth fade + scale animation
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
      child: isImageSelected
          ? SelectedProfileImage(key: const ValueKey('selected'), image: image!)
          : const UnselectedProfileImage(key: ValueKey('unselected')),
    );
  }
}
