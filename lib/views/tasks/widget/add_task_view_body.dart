import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/Logic/TaskCubit/task_cubit.dart';
import 'package:todo_app/extensions/space_exe.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/app_color.dart';
import 'package:todo_app/utils/app_str.dart';
import 'package:todo_app/views/tasks/components/custom_add_task_top_headline_text.dart';
import 'package:todo_app/views/tasks/components/custom_form_text_field.dart';
import 'package:todo_app/views/tasks/components/custom_time_picker_selection_widget.dart';

class AddTaskViewBody extends StatelessWidget {
  AddTaskViewBody({super.key});
  TextEditingController titleTaskController = TextEditingController();
  TextEditingController descriptionTaskController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '';
                  }
                  return null;
                },
              ),
              10.h,
              //description Text Field
              CustomFormTextField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '';
                  }
                  return null;
                },
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
              Padding(
                padding: const EdgeInsets.only(
                  top: 200,
                  bottom: 70.0,
                  left: 30,
                  right: 30,
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      context.read<TaskCubit>().addTask(
                        Task.create(
                          title: titleTaskController.text.trim(),
                          subtitle: descriptionTaskController.text.trim(),
                        ),
                      );
                      titleTaskController.clear();
                      descriptionTaskController.clear();
                      Navigator.pop(context);
                    } else {
                      FancySnackbar.showSnackbar(
                        context,
                        snackBarType: FancySnackBarType.error,
                        title: 'Some required fields are empty',
                        message: 'please fill all the required fields',
                        duration: 5,
                      );
                    }
                  },

                  color: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 55,
                  child: Text(
                    AppStr.addTaskString,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
