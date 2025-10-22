import 'package:todo_app/models/user_model.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthSuccessState extends AuthState {
  final UserModel user;

  AuthSuccessState({required this.user});
}

class AuthFieldState extends AuthState {
  final String errorMas;

  AuthFieldState({required this.errorMas});
}

class LoadingState extends AuthState {}
