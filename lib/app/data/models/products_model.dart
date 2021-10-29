// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) =>
    ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  ProductsModel({
    required this.error,
    required this.mensaje,
    required this.products,
  });

  bool error;
  String mensaje;
  List<Product> products;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        error: json["error"],
        mensaje: json["mensaje"].toString(),
        products: json["products"] != null
            ? List<Product>.from(
                json["products"].map((x) => Product.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "mensaje": mensaje,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.id,
    required this.imageUrl,
  });

  int id;
  String imageUrl;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        imageUrl: json["image_url"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
      };
}
