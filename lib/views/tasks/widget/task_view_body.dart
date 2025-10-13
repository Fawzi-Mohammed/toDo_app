import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:todo_app/extensions/space_exe.dart';
import 'package:todo_app/utils/app_str.dart';
import 'package:todo_app/views/tasks/components/custom_add_task_top_headline_text.dart';
import 'package:todo_app/views/tasks/components/custom_form_text_field.dart';
import 'package:todo_app/views/tasks/components/custom_material_button.dart';
import 'package:todo_app/views/tasks/components/custom_time_picker_selection_widget.dart';

class TaskViewBody extends StatelessWidget {
  TaskViewBody({super.key});
  TextEditingController titleTaskController = TextEditingController();
  TextEditingController descriptionTaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: //100,
                  MediaQuery.of(context).size.height *
                  0.1, // 20% of screen height
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Divider(thickness: 2)),
                  CustomAddTaskTopHeadlineText(textTheme: textTheme),
                  Expanded(child: Divider(thickness: 2)),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                AppStr.titleOfTitleTextField,
                style: textTheme.headlineMedium,
              ),
            ),
            //Title Text Field
            CustomFormTextField(
              controller: titleTaskController,
              onFieldSubmitted: (value) {},
            ),
            10.h,
            //description Text Field
            CustomFormTextField(
              onFieldSubmitted: (value) {},
              controller: descriptionTaskController,
              isForDescription: true,
            ),

            CustomTimePickerSelectionWidget(
              title: AppStr.timeString,
              onTap: () {
                DatePicker.showTimePicker(
                  context,
                  showTitleActions: true,
                  currentTime: DateTime.now(),
                  locale: LocaleType.en,
                  showSecondsColumn: false,
                  onConfirm: (time) {},
                  onCancel: () {},
                );
              },
            ),
            CustomTimePickerSelectionWidget(
              title: AppStr.dateString,
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  currentTime: DateTime.now(),
                  locale: LocaleType.en,
                  minTime: DateTime.now(),
                  onConfirm: (time) {},
                  onCancel: () {},
                );
              },
            ),
           
          ],
        ),
      ),
    );
  }
}
