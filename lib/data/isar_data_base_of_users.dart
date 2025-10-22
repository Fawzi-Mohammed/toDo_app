import 'package:isar/isar.dart';
import 'package:todo_app/data/isar_data_base_service.dart';
import 'package:todo_app/models/user_model.dart';

class IsarDataBaseOfUsers {
  static final _isar = IsarService.isar;

  /// Add a new user
  static Future<int> addUser(UserModel user) async {
    return await _isar.writeTxn(() async {
      return await _isar.userModels.put(user);
    });
  }

  /// Get all users
  static Future<List<UserModel>> getAllUsers() async {
    return await _isar.userModels.where().findAll();
  }

  /// ✅ Get user by email
  static Future<UserModel?> getUserByEmail(String email) async {
    return await _isar.userModels.filter().userEmailEqualTo(email).findFirst();
  }

  /// ✅ Get user by userId (your custom ID)
  static Future<UserModel?> getUserByUserId(String userId) async {
    return await _isar.userModels.filter().userIdEqualTo(userId).findFirst();
  }

  /// Update user (using Isar ID or userId)
  static Future<void> updateUser(UserModel updatedUser) async {
    await _isar.writeTxn(() async {
      await _isar.userModels.put(updatedUser);
    });
  }

  /// Delete user by Isar ID
  static Future<void> deleteUser(int id) async {
    await _isar.writeTxn(() async {
      await _isar.userModels.delete(id);
    });
  }

  /// ✅ Delete user by userId
  static Future<void> deleteUserByUserId(String userId) async {
    final user = await getUserByUserId(userId);
    if (user != null) {
      await deleteUser(user.id);
    }
  }
}
