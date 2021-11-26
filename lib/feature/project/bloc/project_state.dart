import 'package:flutter_bloc_demo/core/failure.dart';
import 'package:flutter_bloc_demo/feature/project/model/project_list_model.dart';

abstract class ProjectState{}

class Initial extends ProjectState{}

class Loading extends ProjectState{}

class ProjectSuccessfulState extends ProjectState{
   ProjectListModel projectListModel;
   ProjectSuccessfulState(this.projectListModel);
}
class Error extends ProjectState{
  String message;
  Error({required this.message});
}