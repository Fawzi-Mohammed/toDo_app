import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/views/tasks/widget/complate_incomplate_task_item.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (Widget child, Animation<double> animation) {
        final offsetAnimation =
            Tween<Offset>(
              begin: const Offset(0.1, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            );

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: offsetAnimation, child: child),
        );
      },

      // Use ValueKey to let AnimatedSwitcher know which widget is which
      child: task.isCompleted
          ? CompletedTaskItem(key: const ValueKey('completed'), task: task)
          : InCompletedTaskItem(key: const ValueKey('incomplete'), task: task),
    );
  }
}
