import 'package:flutter/material.dart';
import 'package:todo_app/utils/app_color.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 0.8),
        ),
        duration: Duration(microseconds: 600),
        child: Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}
