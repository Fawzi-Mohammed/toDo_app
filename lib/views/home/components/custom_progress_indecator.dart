import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Logic/TaskCubit/task_cubit.dart';
import 'package:todo_app/Logic/TaskCubit/task_state.dart';
import 'package:todo_app/extensions/space_exe.dart';
import 'package:todo_app/utils/app_color.dart';
import 'package:todo_app/utils/app_str.dart';

class CustomProgressIndecator extends StatelessWidget {
  const CustomProgressIndecator({super.key, required this.theme});
  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoaded) {
          final totalTasks = state.tasks.length;
          final completedTasks = state.numOfComlatedTask;
          final progress = totalTasks == 0 ? 0.0 : completedTasks / totalTasks;

          return SizedBox(
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated progress indicator
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: progress),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    return SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        value: value,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation(
                          AppColor.primaryColor,
                        ),
                        strokeWidth: 4,
                      ),
                    );
                  },
                ),

                // space
                25.w,

                // task info
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStr.mainTitle, style: theme.displayLarge),
                    3.h,
                    Text(
                      '$completedTasks of $totalTasks tasks',
                      style: theme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text('No tasks yet', style: theme.titleMedium));
        }
      },
    );
  }
}
