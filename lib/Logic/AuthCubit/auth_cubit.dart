
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Logic/AuthCubit/auth_state.dart';
import 'package:todo_app/data/isar_data_base_of_users.dart';
import 'package:todo_app/models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  /// Register a new user
  Future<void> registerUser(UserModel user) async {
    try {
      // Check if user already exists by email
      final existingUser = await IsarDataBaseOfUsers.getUserByEmail(
        user.userEmail,
      );
      if (existingUser != null) {
        emit(AuthFieldState(errorMas: "Email already in use"));

        return;
      }
      await IsarDataBaseOfUsers.addUser(user);

      emit(AuthSuccessState(user: user));
    } catch (e) {
      emit(AuthFieldState(errorMas: e.toString()));
    }
  }

  //Login User
  Future<void> loginUser(String email, String password) async {
    try {
      final user = await IsarDataBaseOfUsers.getUserByEmail(email);
      if (user == null || user.password != password) {
        emit(AuthFieldState(errorMas: "Invalid email or password"));

        return;
      }
      emit(AuthSuccessState(user: user));
      
    } catch (e) {
      emit(AuthFieldState(errorMas: e.toString()));
    }
  }

  /// Update current user info
  Future<void> updateUser(UserModel updatedUser) async {
    try {
      await IsarDataBaseOfUsers.updateUser(updatedUser);
      emit(AuthSuccessState(user: updatedUser));
    } catch (e) {
      emit(AuthFieldState(errorMas: e.toString()));
    }
  }
}
