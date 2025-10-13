import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.15;
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight((kToolbarHeight));
}
