import 'package:flutter/cupertino.dart';

abstract class LoginEvent {}

class LoginCallEvent extends LoginEvent {
  final String email;
  final String password;

  LoginCallEvent(this.email, this.password);
}


