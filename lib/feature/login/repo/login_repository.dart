import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_demo/core/failure.dart';
import 'package:flutter_bloc_demo/feature/login/model/login_model.dart';

abstract class LoginRepository{
Future<Either<Failure, LoginModel>> performLogin(String email, String password);

}