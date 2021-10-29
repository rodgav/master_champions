// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.error,
    required this.mensaje,
    required this.login,
  });

  bool error;
  String mensaje;
  List<Login> login;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        error: json["error"],
        mensaje: json["mensaje"].toString(),
        login: json["login"] != null
            ? List<Login>.from(json["login"].map((x) => Login.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "mensaje": mensaje,
        "login": List<dynamic>.from(login.map((x) => x.toJson())),
      };
}

class Login {
  Login({
    required this.id,
  });

  int id;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
