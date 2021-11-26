import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_demo/api_service/api_service.dart';
import 'package:flutter_bloc_demo/core/failure.dart';
import 'package:flutter_bloc_demo/core/logger.dart';
import 'package:flutter_bloc_demo/feature/project/model/project_list_model.dart';
import 'package:flutter_bloc_demo/feature/project/repo/project_list_repository.dart';

class ProjectListRepositoryImpl extends ProjectListRepository{
  late final Dio dio;
  late final Connectivity connectivity;

  ProjectListRepositoryImpl({required this.dio,required this.connectivity});

  @override
  Future<Either<Failure, ProjectListModel>> getProjectList(String staffId) async{
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      FormData formData =
      new FormData.fromMap({"staffid": staffId});
      logger.i('requested data for LoginAPI $formData');
      try {
        final response = await dio.post(
          ApiService.baseUrl + ApiService.projectListEndpoint,
          data: formData,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
        );
        logger.i('response for ProjectListAPI : ${response.data}');

        var jsonString = json.encode(response.data);
        if (response.statusCode == 200) {
          logger.i('ProjectList successfully done.');
          return right(ProjectListModel(status: true,
              message: response.statusMessage!,
              detail: projectListModelFromJson(response.data).detail));

        } else {
          return left(Failure("Error status Code : ${response.statusCode}"));
        }
      } on DioError catch (e) {
        logger.e(e.response!.data);
        final message = (e.response!.data as Map<String, dynamic>)['error_description'] as String;
        return left(Failure(message));
      } on SocketException catch (e) {
        logger.e(e);
        return left(Failure('Please check the network connection'));
      } on Exception catch (e) {
        logger.e(e);
        return left(Failure('Unexpected Error occurred'));
      }
    } else {
      return left(Failure('Please check your internet connection'));
    }
  }
}