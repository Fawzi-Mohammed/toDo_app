import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:todo_app/models/user_model.dart';

class SharedPrefesOfLoggedInUser {
  static const _keyUser = 'logged_in_user';
  static late SharedPreferences _prefs;

  /// Initialize SharedPreferences (custom Android file name)
  static Future<void> init() async {
    // Configure Android-specific options (no custom options required for registration)
    SharedPreferencesAndroid.registerWith();

    _prefs = await SharedPreferences.getInstance();
  }

  /// Save or add a user (overwrites if already exists)
  static Future<void> saveUser(UserModel user) async {
    await _prefs.setString(_keyUser, user.toJson());
  }

  /// Get the saved user
  static UserModel? getUser() {
    final jsonString = _prefs.getString(_keyUser);
    if (jsonString == null) return null;
    return UserModel.fromJson(jsonString);
  }

  /// Update user (essentially same as save)
  static Future<void> updateUser(UserModel user) async {
    await saveUser(user);
  }

  /// Delete the saved user
  static Future<void> deleteUser() async {
    await _prefs.remove(_keyUser);
  }

  /// Check if a user is saved
  static bool hasUser() {
    return _prefs.containsKey(_keyUser);
  }
}
