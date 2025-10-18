import 'package:flutter/material.dart';
import 'package:todo_app/utils/app_color.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.isCompleted});
  final bool isCompleted;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: isCompleted ? AppColor.primaryColor : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey, width: 0.8),
      ),
      duration: Duration(microseconds: 600),
      child: Icon(
        isCompleted ? Icons.check : Icons.check_box_rounded,
        color: Colors.white,
      ),
    );
  }
}
