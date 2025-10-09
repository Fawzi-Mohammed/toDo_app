import 'package:flutter/material.dart';

class ItemTitle extends StatelessWidget {
  const ItemTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.only(bottom: 5.0, top: 3),
          child: Text(
            'Done',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        );
  }
}