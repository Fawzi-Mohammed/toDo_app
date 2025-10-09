import 'package:flutter/material.dart';

extension IntExtension on int? {
  int validate({int value = 0}) {
    return this ?? value;
  }

  get h => SizedBox(height: this?.toDouble());
  get w => SizedBox(width: this?.toDouble());
}
