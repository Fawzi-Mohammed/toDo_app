import 'package:isar/isar.dart';
part 'user_model.g.dart'; // 👈 required for code generation

@Collection()
class UserModel {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  final String userId;
  final String userName;
  final String userProfilePhoto;
  final String userJob;
  UserModel(this.userJob, {
    required this.userId,
    required this.userName,
    required this.userProfilePhoto,
  });
}
