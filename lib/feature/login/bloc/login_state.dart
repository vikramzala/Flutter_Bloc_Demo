import 'package:flutter_bloc_demo/feature/login/model/login_model.dart';

abstract class LoginState {}

class Initial extends LoginState {}

class Loading extends LoginState {}

class LoginSuccessfulState extends LoginState {
  final LoginModel loginModel;

  LoginSuccessfulState(this.loginModel);
}

class Error extends LoginState {
  final String message;

  Error({required this.message});
}
