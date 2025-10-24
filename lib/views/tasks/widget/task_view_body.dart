import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Logic/TaskCubit/task_cubit.dart';
import 'package:todo_app/extensions/space_exe.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/app_color.dart';
import 'package:todo_app/utils/app_str.dart';
import 'package:todo_app/views/tasks/components/custom_add_task_top_headline_text.dart';
import 'package:todo_app/views/tasks/components/custom_form_text_field.dart';
import 'package:todo_app/views/tasks/components/custom_time_picker_selection_widget.dart';

class TaskViewBody extends StatefulWidget {
  const TaskViewBody({super.key, this.isUpdate = false, this.task});

  @override
  State<TaskViewBody> createState() => _TaskViewBodyState();
  final bool isUpdate;
  final Task? task;
}

class _TaskViewBodyState extends State<TaskViewBody> {
  TextEditingController titleTaskController = TextEditingController();

  TextEditingController descriptionTaskController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String dateAtTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String dateOfCreated = DateFormat(
    'E, MMM d, yyyy',
  ).format(DateTime.now()).toString();

  @override
  void initState() {
    if (widget.isUpdate) {
      titleTaskController = TextEditingController(text: widget.task!.title);
      descriptionTaskController = TextEditingController(
        text: widget.task!.subTitle,
      );
      dateAtTime = widget.task!.createdAtTime;
      dateOfCreated = widget.task!.createdAtDate;
      setState(() {});
    }
    super.initState();
  }

  @override
  void dispose() {
    titleTaskController.dispose();
    descriptionTaskController.dispose();
    super.dispose();
  }

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
                    CustomAddTaskTopHeadlineText(
                      textTheme: textTheme,
                      isUpdate: widget.isUpdate,
                    ),
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
                isTime: true,
                title: AppStr.timeString,
                onTap: () {
                  DatePicker.showTime12hPicker(
                    context,
                    showTitleActions: true,
                    currentTime: DateTime.now(),
                    locale: LocaleType.en,

                    onConfirm: (time) {
                      dateAtTime = DateFormat(
                        'hh:mm a',
                      ).format(time).toString();
                      setState(() {});
                    },
                  );
                },
                date: dateAtTime,
              ),
              CustomTimePickerSelectionWidget(
                isTime: false,
                date: dateOfCreated,
                title: AppStr.dateString,
                onTap: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    currentTime: DateTime.now(),
                    locale: LocaleType.en,
                    minTime: DateTime.now(),
                    onConfirm: (time) {
                      dateOfCreated = DateFormat(
                        'E, MMM d, yyyy',
                      ).format(time).toString();
                      setState(() {});
                    },
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
                      final taskCubit = context.read<TaskCubit>();
                      final userId = taskCubit.currentUserId;

                      if (userId == null) {
                        FancySnackbar.showSnackbar(
                          context,
                          snackBarType: FancySnackBarType.error,
                          title: 'User not found',
                          message: 'Please log in again to add tasks.',
                          duration: 2,
                        );

                        return;
                      }

                      if (widget.isUpdate) {
                        widget.task!
                          ..title = titleTaskController.text.trim()
                          ..subTitle = descriptionTaskController.text.trim()
                          ..createdAtTime = dateAtTime
                          ..createdAtDate = dateOfCreated;

                        taskCubit.updateTask(widget.task!);
                      } else {
                        taskCubit.addTask(
                          Task.create(
                            title: titleTaskController.text.trim(),
                            subtitle: descriptionTaskController.text.trim(),
                            createdAtTime: dateAtTime,
                            createdAtDate: dateOfCreated,
                            userID: userId,
                          ),
                        );
                      }

                      FancySnackbar.showSnackbar(
                        context,
                        snackBarType: FancySnackBarType.success,
                        duration: 3,
                        title: widget.isUpdate
                            ? 'Task Updated Successfully'
                            : 'Task Added Successfully',
                        message: '',
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
                        duration: 2,
                      );
                    }
                  },

                  color: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 55,
                  child: Text(
                    widget.isUpdate
                        ? AppStr.updateCurrentTask
                        : AppStr.addTaskString,
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
