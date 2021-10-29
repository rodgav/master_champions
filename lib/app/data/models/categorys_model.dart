// To parse this JSON data, do
//
//     final categorysModel = categorysModelFromJson(jsonString);

import 'dart:convert';

CategorysModel categorysModelFromJson(String str) =>
    CategorysModel.fromJson(json.decode(str));

String categorysModelToJson(CategorysModel data) => json.encode(data.toJson());

class CategorysModel {
  CategorysModel({
    required this.error,
    required this.mensaje,
    required this.categorys,
  });

  bool error;
  String mensaje;
  List<Category> categorys;

  factory CategorysModel.fromJson(Map<String, dynamic> json) => CategorysModel(
        error: json["error"],
        mensaje: json["mensaje"].toString(),
        categorys: json["categorys"] != null
            ? List<Category>.from(
                json["categorys"].map((x) => Category.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "mensaje": mensaje,
        "categorys": List<dynamic>.from(categorys.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
