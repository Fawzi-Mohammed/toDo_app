import 'package:isar/isar.dart';
import 'package:intl/intl.dart';

part 'task.g.dart'; // 👈 required for code generation

@collection
class Task {
  Id id = Isar.autoIncrement;

  late String title;
  late String subTitle;
  late String createdAtTime;
  late String createdAtDate;
  late bool isCompleted;

  Task({
    required this.title,
    required this.subTitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted,
  });

  factory Task.create({
    required String? title,
    required String? subtitle,
    String? createdAtTime,
    String? CreatedAtDate,
  }) => Task(
    title: title ?? '',
    subTitle: subtitle ?? '',
    createdAtTime:
        createdAtTime ??
        DateFormat('hh:mm a').format(DateTime.now()).toString(),
    createdAtDate:
        CreatedAtDate ??
        DateFormat('E, MMM d, yyyy').format(DateTime.now()).toString(),
    isCompleted: false,
  );
}
