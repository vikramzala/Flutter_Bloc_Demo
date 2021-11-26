import 'dart:ffi';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/feature/login/bloc/login_bloc.dart';
import 'package:flutter_bloc_demo/feature/login/repo/login_repository.dart';
import 'package:flutter_bloc_demo/feature/login/repo/login_repository_impl.dart';
import 'package:flutter_bloc_demo/feature/project/bloc/project_bloc.dart';
import 'package:flutter_bloc_demo/feature/project/repo/project_list_repository.dart';
import 'package:flutter_bloc_demo/feature/project/repo/project_list_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External /* All the other required external injection are embedded here */
  await _initExternalDependencies();

  // Repository /* All the repository injection are embedded here */
  _initRepositories();

  // Bloc /* All the bloc injection are embedded here */
  _initBlocs();
}

void _initBlocs() {
  sl.registerFactory(() => LoginBloc(repository: sl()));
  sl.registerFactory(() => ProjectBloc(repository: sl()));
}

void _initRepositories() {
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(dio: sl(), connectivity: sl()));
  sl.registerLazySingleton<ProjectListRepository>(
          () => ProjectListRepositoryImpl(dio: sl(), connectivity: sl()));
}

Future<void> _initExternalDependencies() async {
  sl.registerLazySingleton(() => Dio());
  // sl.registerLazySingleton(() => GetIt.I());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => Logger());
  // sl.registerLazySingleton(() => Bloc);
  sl.registerLazySingleton(() => Dart_CObject());
}
