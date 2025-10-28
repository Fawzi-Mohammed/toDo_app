import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
part 'user_model.g.dart'; // 👈 required for code generation

@Collection()
class UserModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  final String userId;

   String userName;
   String? userProfilePhotoPath;
   String userJob;
  final String userEmail;
   String password;

  int taskCount;
  int completedTaskCount;

  UserModel({
    required this.password,
    required this.userEmail,
    required this.userJob,
    required this.userName,
    required this.userProfilePhotoPath,
    this.taskCount = 0,
    this.completedTaskCount = 0,
    String userId = '',
  }) : userId = userId.isEmpty ? const Uuid().v4() : userId;

  String toJson() {
    return jsonEncode({
      'userId': userId,
      'userName': userName,
      'userProfilePhotoPath': userProfilePhotoPath,
      'userJob': userJob,
      'userEmail': userEmail,
      'password': password,
      'taskCount': taskCount,
      'completedTaskCount': completedTaskCount,
    });
  }

  factory UserModel.fromJson(String jsonString) {
    final map = jsonDecode(jsonString);
    return UserModel(
      userName: map['userName'],
      userProfilePhotoPath: map['userProfilePhotoPath'],
      userJob: map['userJob'],
      userEmail: map['userEmail'],
      password: map['password'],
      taskCount: map['taskCount'] ?? 0,
      completedTaskCount: map['completedTaskCount'] ?? 0,
      userId: map['userId'] ?? '',
    );
  }
}
