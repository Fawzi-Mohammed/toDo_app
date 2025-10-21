import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/Logic/TaskCubit/task_cubit.dart';
import 'package:todo_app/extensions/space_exe.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/app_str.dart';
import 'package:todo_app/views/tasks/components/Item_task_description.dart';
import 'package:todo_app/views/tasks/components/custom_icon.dart';
import 'package:todo_app/views/tasks/components/item_title.dart';

class InCompletedTaskItem extends StatelessWidget {
  const InCompletedTaskItem({super.key, required this.task});
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      onDismissed: (_) {
        context.read<TaskCubit>().deleteTask(task.id);
      },
      background: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.delete_outline, color: Colors.grey),
          8.w,
          Text(AppStr.deleteTask),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          context.go('/tasks', extra: {'isUpdate': true, 'task': task});
        },
        child: AnimatedContainer(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          duration: const Duration(milliseconds: 600),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .1),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
            color: Colors.white,
          ),
          child: ListTile(
            leading: GestureDetector(
              onTap: () {
                if (task.isCompleted == false) {
                  task.isCompleted = true;
                } else {
                  task.isCompleted = false;
                }
                context.read<TaskCubit>().updateTask(task);
              },
              child: CustomIcon(isCompleted: task.isCompleted),
            ),
            //Task Title
            title: ItemTitle(title: task.title, isCompleted: task.isCompleted),
            //Task Description
            subtitle: ItemTaskDescription(
              isCompleted: task.isCompleted,
              description: task.subTitle,
              timeOfCreation: task.createdAtTime,
              dateOfCreation: task.createdAtDate,
            ),
          ),
        ),
      ),
    );
  }
}

class CompletedTaskItem extends StatelessWidget {
  const CompletedTaskItem({super.key, required this.task});
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      onDismissed: (_) {
        context.read<TaskCubit>().deleteTask(task.id);
      },
      background: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.delete_outline, color: Colors.grey),
          8.w,
          Text(AppStr.deleteTask),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          context.go('/tasks', extra: {'isUpdate': true, 'task': task});
        },
        child: AnimatedContainer(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          duration: const Duration(milliseconds: 600),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .1),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
            color: Color.fromARGB(154, 119, 144, 229),
          ),
          child: ListTile(
            leading: GestureDetector(
              onTap: () {
                if (task.isCompleted == false) {
                  task.isCompleted = true;
                } else {
                  task.isCompleted = false;
                }
                context.read<TaskCubit>().updateTask(task);
              },
              child: CustomIcon(isCompleted: task.isCompleted),
            ),
            //Task Title
            title: ItemTitle(title: task.title, isCompleted: task.isCompleted),
            //Task Description
            subtitle: ItemTaskDescription(
              isCompleted: task.isCompleted,
              description: task.subTitle,
              timeOfCreation: task.createdAtTime,
              dateOfCreation: task.createdAtDate,
            ),
          ),
        ),
      ),
    );
  }
}
