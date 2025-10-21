import 'package:flutter/material.dart';
import 'package:todo_app/utils/app_color.dart';

class ItemTaskDescription extends StatelessWidget {
  const ItemTaskDescription({
    super.key,
    required this.description,
    required this.timeOfCreation,
    required this.dateOfCreation,
    required this.isCompleted,
  });
  final String description;
  final String timeOfCreation;
  final String dateOfCreation;
  final bool isCompleted;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description,
          style: TextStyle(
            color: isCompleted ? AppColor.primaryColor : Colors.grey.shade700,
            decoration: isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            decorationColor: isCompleted ? AppColor.primaryColor : Colors.black,
            decorationThickness: isCompleted ? 2 : 0,
            fontWeight: FontWeight.w500,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  timeOfCreation.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: isCompleted ? Colors.white : Colors.grey.shade700,
                  ),
                ),
                Text(
                  dateOfCreation.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: isCompleted ? Colors.white : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
