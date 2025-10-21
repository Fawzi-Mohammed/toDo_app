import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/views/tasks/components/task_view_app_bar.dart';
import 'package:todo_app/views/tasks/widget/task_view_body.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key, this.isUpdate = false, this.task,});
  final bool isUpdate;
  final Task? task;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: TaskViewAppBar(),
        body: TaskViewBody(isUpdate: isUpdate,task: task,),
      ),
    );
  }
}
