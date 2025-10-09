import 'package:flutter/material.dart';
import 'package:todo_app/extensions/space_exe.dart';
import 'package:todo_app/views/home/components/custom_progress_indecator.dart';
import 'package:todo_app/views/home/components/custom_floting_action_button.dart';
import 'package:todo_app/views/home/components/custom_slider_drawer.dart';
import 'package:todo_app/views/home/widget/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: const CustomFloatingActionButton(),
      body: SafeArea(
        child: CustomSliderDrawer(
          widget: Column(
            children: [
              30.h,
              CustomProgressIndecator(theme: theme),

              //Divider
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Divider(thickness: 2, indent: 100),
              ),
              HomeViewBody(),
            ],
          ),
        ),
      ),
    );
  }
}
