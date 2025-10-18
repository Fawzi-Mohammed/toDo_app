import 'package:flutter/material.dart';
import 'package:todo_app/views/home/widget/task_list_view_builder.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key,});
  @override
  Widget build(BuildContext context) {
    return TaskListViewBuilder();
  }
}
