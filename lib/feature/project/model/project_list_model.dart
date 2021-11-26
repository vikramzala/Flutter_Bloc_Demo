// To parse this JSON data, do
//
//     final projectListModel = projectListModelFromJson(jsonString);

import 'dart:convert';

ProjectListModel projectListModelFromJson(String str) => ProjectListModel.fromJson(json.decode(str));

String projectListModelToJson(ProjectListModel data) => json.encode(data.toJson());

class ProjectListModel {
  ProjectListModel({
   required this.status,
    required this.message,
    required this.detail,
  });

  bool status;
  String message;
  List<Detail> detail;

  factory ProjectListModel.fromJson(Map<String, dynamic> json) => ProjectListModel(
    status: json["status"],
    message: json["message"],
    detail: List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
  };
}

class Detail {
  Detail({
    required this.projectId,
    required this.name,
  });

  String projectId;
  String name;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    projectId: json["project_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "project_id": projectId,
    "name": name,
  };
}
