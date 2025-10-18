import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Logic/TaskCubit/task_cubit.dart';
import 'package:todo_app/Logic/TaskCubit/task_state.dart';
import 'package:todo_app/views/home/widget/no_item_home%20widget.dart';
import 'package:todo_app/views/tasks/widget/task_item.dart';

class TaskListViewBuilder extends StatelessWidget {
  const TaskListViewBuilder({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoaded) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                return TaskItem(task: state.tasks[index]);
              },
            ),
          );
        } else if (state is TaskEmpty) {
          return NoItemHomeWidget(isEmpty: true);
        } else {
          return NoItemHomeWidget(isEmpty: true);
        }
      },
    );
  }
}
