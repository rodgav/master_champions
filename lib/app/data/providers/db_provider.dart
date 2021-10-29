import 'package:flutter/material.dart';
import 'package:master_champions/app/core/utils/helpers/http/http.dart';
import 'package:master_champions/app/data/models/categorys_model.dart';
import 'package:master_champions/app/data/models/products_model.dart';
import 'package:master_champions/app/data/models/response_model.dart';
import 'package:master_champions/app/data/models/user_model.dart';

class DbProvider {
  final Http _http;

  DbProvider(this._http);

  Future<UserModel?> login(
      {required String user, required String password}) async {
    try {
      final result = await _http.request('',
          method: HttpMethod.post,
          headers: {'token': '13jsadnb8132bsad23'},
          body: {'accion': 'login', 'email': user, 'password': password});
      return UserModel.fromJson(result.data);
    } catch (_) {   debugPrint('_ $_');
      return null;
    }
  }

  Future<ResponseModel?> createCategory({required String name}) async {
    try {
      final result = await _http.request('',
          method: HttpMethod.post,
          headers: {'token': '13jsadnb8132bsad23'},
          body: {'accion': 'category', 'name': name});
      return ResponseModel.fromJson(result.data);
    } catch (_) {   debugPrint('_ $_');
      return null;
    }
  }

  Future<ResponseModel?> createProduct(
      {required int idCategory, required String image}) async {
    try {
      final result = await _http.request('', method: HttpMethod.post, headers: {
        'token': '13jsadnb8132bsad23'
      }, body: {
        'accion': 'product',
        'idCategory': idCategory.toString(),
        'image': image
      });
      return ResponseModel.fromJson(result.data);
    } catch (_) {   debugPrint('_ $_');
      return null;
    }
  }

  Future<CategorysModel?> getCategorys() async {
    try {
      final result = await _http.request('',
          method: HttpMethod.get,
          headers: {'token': '13jsadnb8132bsad23'},
          queryParameters: {'accion': 'categorys'});
      return CategorysModel.fromJson(result.data);
    } catch (_) {   debugPrint('_ $_');
      return null;
    }
  }

  Future<ProductsModel?> getProducts10() async {
    try {
      final result = await _http.request('',
          method: HttpMethod.get,
          headers: {'token': '13jsadnb8132bsad23'},
          queryParameters: {'accion': 'products10'});
      return ProductsModel.fromJson(result.data);
    } catch (_) {
      debugPrint('_ $_');
      return null;
    }
  }

  Future<ProductsModel?> getProducts({required int idCategory}) async {
    try {
      final result = await _http.request('', method: HttpMethod.get, headers: {
        'token': '13jsadnb8132bsad23'
      }, queryParameters: {
        'accion': 'products',
        'idCategory': idCategory.toString()
      });
      return ProductsModel.fromJson(result.data);
    } catch (_) {   debugPrint('_ $_');
      return null;
    }
  }
}