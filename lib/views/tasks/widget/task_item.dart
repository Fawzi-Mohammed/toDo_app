import 'package:flutter/material.dart';
import 'package:todo_app/extensions/space_exe.dart';
import 'package:todo_app/utils/app_color.dart';
import 'package:todo_app/utils/app_str.dart';
import 'package:todo_app/views/tasks/components/Item_task_description.dart';
import 'package:todo_app/views/tasks/components/custom_icon.dart';
import 'package:todo_app/views/tasks/components/item_title.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      onDismissed: (_) {
        // we will remove current task from Db
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
          //Navigate to Task View to see Task Details
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
            color: AppColor.primaryColor.withValues(alpha: 0.3),
          ),
          child: ListTile(
            leading: CustomIcon(),
            //Task Title
            title: ItemTitle(),
            //Task Description
            subtitle: ItemTaskDescription(),
          ),
        ),
      ),
    );
  }
}
