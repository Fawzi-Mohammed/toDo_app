import 'package:flutter/material.dart';

class ItemTaskDescription extends StatelessWidget {
  const ItemTaskDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Date',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  'SubDate',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
