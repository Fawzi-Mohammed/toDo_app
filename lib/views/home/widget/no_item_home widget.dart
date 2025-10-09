import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/utils/app_str.dart';
import 'package:todo_app/utils/constants.dart';

class NoItemHomeWidget extends StatelessWidget {
  const NoItemHomeWidget({super.key, required this.isEmpty});
  final bool isEmpty;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeIn(
            child: Lottie.asset(
              lottieURL,
              animate: isEmpty,
              height: 200,
              width: 200,
            ),
          ),
          FadeInUp(from: 30, child: const Text(AppStr.doneAllTask)),
        ],
      ),
    );
  }
}
