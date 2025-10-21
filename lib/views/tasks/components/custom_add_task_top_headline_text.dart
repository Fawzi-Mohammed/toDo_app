import 'package:flutter/material.dart';
import 'package:todo_app/utils/app_str.dart';

class CustomAddTaskTopHeadlineText extends StatelessWidget {
  const CustomAddTaskTopHeadlineText({
    super.key,
    required this.textTheme,
    required this.isUpdate,
  });
  final TextTheme textTheme;
  final bool isUpdate;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: isUpdate ? AppStr.updateTaskString : AppStr.addNewTask,
        style: textTheme.titleLarge,
        children: [
          TextSpan(
            text: isUpdate ? null : AppStr.taskStrnig,
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
