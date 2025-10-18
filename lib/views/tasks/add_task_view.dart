import 'package:flutter/material.dart';
import 'package:todo_app/views/tasks/components/task_view_app_bar.dart';
import 'package:todo_app/views/tasks/widget/add_task_view_body.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: TaskViewAppBar(),
        body: Column(children: [Expanded(child: AddTaskViewBody())]),
      ),
    );
  }
}
