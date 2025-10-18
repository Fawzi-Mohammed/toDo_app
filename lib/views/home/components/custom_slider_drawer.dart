import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:todo_app/Logic/TaskCubit/task_cubit.dart';
import 'package:todo_app/Logic/TaskCubit/task_state.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/views/home/components/custom_slider_drawer_body.dart';

class CustomSliderDrawer extends StatelessWidget {
  const CustomSliderDrawer({super.key, required this.widget});
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TaskEmptyDelateWarning) {
          noTaskWarning(context);
        } else if (state is TaskDelateAllWarning) {
          deleateAllTask(context);
        }
      },
      child: SliderDrawer(
        animationDuration: 1000,
        appBar: SliderAppBar(
          config: SliderAppBarConfig(
            title: Text(''),
            drawerIconSize: 30,
            trailing: IconButton(
              onPressed: () {
                context.read<TaskCubit>().deleteAllTasks();
              },
              icon: Icon(CupertinoIcons.trash_fill, size: 30),
            ),
          ),
        ),
        isDraggable: false,
        slider: CustomSliderDrawerBody(),
        child: widget,
      ),
    );
  }
}
