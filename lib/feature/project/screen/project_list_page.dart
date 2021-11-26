import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/core/injection_container.dart';
import 'package:flutter_bloc_demo/feature/project/bloc/project_bloc.dart';
import 'package:flutter_bloc_demo/feature/project/screen/project_list_screen.dart';

class ProjectListPage extends StatefulWidget {
  String staffid;
   ProjectListPage(this.staffid, {Key? key}) : super(key: key);

  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectBloc>(
      create: (_) => sl<ProjectBloc>(),
      child: ProjectList(widget.staffid),
    );
  }
}
