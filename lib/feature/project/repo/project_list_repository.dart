import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_demo/core/failure.dart';
import 'package:flutter_bloc_demo/feature/project/model/project_list_model.dart';

abstract class ProjectListRepository{
  Future<Either<Failure,ProjectListModel>> getProjectList(String staffId);
}