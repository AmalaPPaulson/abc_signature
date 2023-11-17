part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoadingST extends LoginState {}

class LoadedST extends LoginState {}

class LoginSuccessST extends LoginState {
  final String? name;

  LoginSuccessST({
    required this.name,
  });
}

class LoginFailureST extends LoginState {
  final String? errorMsg;

  LoginFailureST({required this.errorMsg});
}

class ClearST extends LoginState {}
