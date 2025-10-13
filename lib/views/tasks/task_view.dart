import 'package:flutter/material.dart';
import 'package:todo_app/utils/app_color.dart';
import 'package:todo_app/utils/app_str.dart';
import 'package:todo_app/views/tasks/components/custom_material_button.dart';
import 'package:todo_app/views/tasks/components/task_view_app_bar.dart';
import 'package:todo_app/views/tasks/widget/task_view_body.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: TaskViewAppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: TaskViewBody()),
            Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomMaterialButton(
                    icon: Icons.close,
                    textColor: AppColor.primaryColor,
                    title: AppStr.addNote,
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  MaterialButton(
                    onPressed: () {},
                    minWidth: 150,
                    color: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 55,
                    child: Row(
                      children: [
                        Text(
                          AppStr.addTaskString,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
