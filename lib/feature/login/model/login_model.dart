// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.status,
    required this.message,
    required this.detail,
  });

  bool status;
  String message;
  Detail detail;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"],
    detail: Detail.fromJson(json["detail"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "detail": detail.toJson(),
  };
}

class Detail {
  Detail({
    required this.staffid,
   required this.email,
   required this.password,
   required this.firstname,
   required this.lastname,
   required this.phonenumber,
   required this.projectId,
   required this.role,
   required this.tokenId,
  });

  String staffid;
  String email;
  String password;
  String firstname;
  String lastname;
  String phonenumber;
  String projectId;
  String role;
  String tokenId;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    staffid: json["staffid"],
    email: json["email"],
    password: json["password"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    phonenumber: json["phonenumber"],
    projectId: json["project_id"],
    role: json["role"],
    tokenId: json["token_id"],
  );

  Map<String, dynamic> toJson() => {
    "staffid": staffid,
    "email": email,
    "password": password,
    "firstname": firstname,
    "lastname": lastname,
    "phonenumber": phonenumber,
    "project_id": projectId,
    "role": role,
    "token_id": tokenId,
  };
}