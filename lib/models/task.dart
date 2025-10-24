import 'package:isar/isar.dart';
import 'package:intl/intl.dart';

part 'task.g.dart'; // dY`^ required for code generation

@collection
class Task {
  Id id = Isar.autoIncrement;

  late String title;
  late String subTitle;
  late String createdAtTime;
  late String createdAtDate;
  late bool isCompleted;
  String userID = '';

  Task({
    required this.title,
    required this.subTitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted,
  });

  factory Task.create({
    String? title,
    String? subtitle,
    String? createdAtTime,
    String? createdAtDate,
    required String userID,
  }) {
    return Task(
      title: title ?? '',
      subTitle: subtitle ?? '',
      createdAtTime:
          createdAtTime ??
          DateFormat('hh:mm a').format(DateTime.now()).toString(),
      createdAtDate:
          createdAtDate ??
          DateFormat('E, MMM d, yyyy').format(DateTime.now()).toString(),
      isCompleted: false,
    )..userID = userID;
  }
}
