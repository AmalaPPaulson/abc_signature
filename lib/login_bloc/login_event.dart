part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginPressET extends LoginEvent{
  final String? userId;
  final String? password;

  LoginPressET({
    required this.userId,
    required this.password,
  });
}
