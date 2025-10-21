import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/utils/app_color.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/tasks');
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            //  size: 35,
          ),
        ),
      ),
    );
  }
}
