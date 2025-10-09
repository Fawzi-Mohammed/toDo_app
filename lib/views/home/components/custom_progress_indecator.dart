import 'package:flutter/material.dart';
import 'package:todo_app/extensions/space_exe.dart';
import 'package:todo_app/utils/app_color.dart';
import 'package:todo_app/utils/app_str.dart';

class CustomProgressIndecator extends StatelessWidget {
  const CustomProgressIndecator({super.key, required this.theme});
  final TextTheme theme;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //progress indicator
          SizedBox(
            width: 30,
            height: 30,
            child: const CircularProgressIndicator(
              value: 1 / 3,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation(AppColor.primaryColor),
            ),
          ),
    
          //space
          25.w,
          //Top level Task info
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStr.mainTitle, style: theme.displayLarge),
              3.h,
              Text('1 of 3 task', style: theme.titleMedium),
            ],
          ),
        ],
      ),
    );
  }
}
