import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/feature/project/bloc/project_bloc.dart';
import 'package:flutter_bloc_demo/feature/project/bloc/project_event.dart';
import 'package:flutter_bloc_demo/feature/project/bloc/project_state.dart';
import 'package:flutter_bloc_demo/feature/project/model/project_list_model.dart';

class ProjectList extends StatefulWidget {
  String staffId;

  ProjectList(this.staffId, {Key? key}) : super(key: key);

  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  List<Detail> details = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProjectData(widget.staffId);
  }

  void getProjectData(String staffId) {
    context.read<ProjectBloc>().add(ProjectGetEvent(staffId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (BuildContext ctx, state) async {
        if (state is Error) {
          final snackBar = SnackBar(content: Text(state.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is ProjectSuccessfulState) {
          if (state.projectListModel.detail != null) {
            details = state.projectListModel.detail;
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Project List'),
        ),
        body: BlocBuilder<ProjectBloc, ProjectState>(builder: (context, state) {
          if (state is Loading) {
            return SizedBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Builder(builder: (BuildContext ctx) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                // itemCount: CatalogueModel.items.length,
                itemCount: details.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      details[index].name,
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  );
                },
              );
            });
          }
        }),
      ),
    );
  }


}
