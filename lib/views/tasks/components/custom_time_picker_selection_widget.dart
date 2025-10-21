import 'package:flutter/material.dart';

class CustomTimePickerSelectionWidget extends StatelessWidget {
  const CustomTimePickerSelectionWidget({
    super.key,
    this.onTap,
    required this.title,
    required this.date,
    required this.isTime,
  });
  final void Function()? onTap;
  final String title;
  final String date;
  final bool isTime;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),

          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: isTime ? 0 : 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(title, style: textTheme.headlineSmall),
              ),
            ),
            Expanded(
              flex: isTime ? 0 : 2,
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 80,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text(date, style: textTheme.titleSmall)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
