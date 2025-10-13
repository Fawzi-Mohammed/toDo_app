import 'package:flutter/material.dart';
import 'package:todo_app/extensions/space_exe.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    super.key,
    required this.title,
    required this.color,
    required this.onPressed,
   required this.icon,
    required this.textColor,
  });
  final String title;
  final IconData icon;
  final Color textColor;
  final Color color;

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: 150,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      height: 55,
      child: Row(
        children: [
          Icon(icon, color: textColor),
          5.w,
          Text(title, style: TextStyle(color: textColor)),
        ],
      ),
    );
  }
}
