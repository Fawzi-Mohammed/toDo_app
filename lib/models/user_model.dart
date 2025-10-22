import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
part 'user_model.g.dart'; // 👈 required for code generation

@Collection()
class UserModel {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  final String userId;
  final String userName;
  final String userProfilePhoto;
  final String userJob;
  final String userEmail;
  final String password;
  UserModel({
    required this.password,
    required this.userEmail,
    required this.userJob,
    required this.userName,
    required this.userProfilePhoto,
  }) : userId = const Uuid().v4();
}
