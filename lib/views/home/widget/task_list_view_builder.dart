import 'package:flutter/material.dart';
import 'package:todo_app/views/home/widget/no_item_home%20widget.dart';
import 'package:todo_app/views/tasks/widget/task_item.dart';

class TaskListViewBuilder extends StatelessWidget {
  const TaskListViewBuilder({super.key});
  final List items = const [];
  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? NoItemHomeWidget(isEmpty: items.isEmpty)
        : Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return TaskItem();
              },
            ),
          );
  }
}
