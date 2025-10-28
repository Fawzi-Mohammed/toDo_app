import 'package:flutter/material.dart';
import 'package:todo_app/extensions/space_exe.dart';

class SliderDrawerItemWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SliderDrawerItemWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withValues(alpha: .2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 300),
              scale: isSelected ? 1.2 : 1.0,
              child: Icon(icon, color: Colors.white, size: 26),
            ),
            10.w,
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: textTheme.titleMedium!.copyWith(
                color: isSelected ? Colors.white : Colors.white.withValues(alpha: .8),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
