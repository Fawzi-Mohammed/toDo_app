import 'package:flutter/material.dart';
import 'package:todo_app/utils/app_color.dart';

class ItemTitle extends StatelessWidget {
  const ItemTitle({super.key, required this.title, required this.isCompleted});
  final String title;
  final bool isCompleted;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 3),
      child: Text(
        title,
        style: TextStyle(
          color: isCompleted ? AppColor.primaryColor : Colors.black,

          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
