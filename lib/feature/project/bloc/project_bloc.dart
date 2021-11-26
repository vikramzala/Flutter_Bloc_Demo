import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/feature/project/bloc/project_event.dart';
import 'package:flutter_bloc_demo/feature/project/bloc/project_state.dart';
import 'package:flutter_bloc_demo/feature/project/repo/project_list_repository.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectListRepository repository;

  ProjectBloc({required this.repository}) : super(Initial());

  @override
  Stream<ProjectState> mapEventToState(ProjectEvent event) async* {
    yield Loading();
    if (event is ProjectGetEvent) {
      final data = await repository.getProjectList(event.staffId);
      yield data.fold((failure) => Error(message: failure.message),
          (r) => ProjectSuccessfulState(r));
    }
  }
}
