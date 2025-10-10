import 'package:flutter/material.dart';
import 'package:todo_app/utils/app_str.dart';

class CustomAddTaskTopHeadlineText extends StatelessWidget {
  const CustomAddTaskTopHeadlineText({super.key,required this.textTheme});
    final TextTheme textTheme;

  @override
  Widget build(BuildContext context,) {
    return RichText(
      text: TextSpan(
        text: AppStr.addNewTask,
        style: textTheme.titleLarge,
        children: [
          TextSpan(
            text: AppStr.taskStrnig,
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
