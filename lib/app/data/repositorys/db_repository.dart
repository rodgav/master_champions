import 'package:get/get.dart';
import 'package:master_champions/app/data/models/categorys_model.dart';
import 'package:master_champions/app/data/models/products_model.dart';
import 'package:master_champions/app/data/models/response_model.dart';
import 'package:master_champions/app/data/models/user_model.dart';
import 'package:master_champions/app/data/providers/db_provider.dart';

class DbRepository {
  final _dbProvider = Get.find<DbProvider>();

  Future<UserModel?> login({required String user, required String password}) =>
      _dbProvider.login(user: user, password: password);

  Future<ResponseModel?> createCategory({required String name}) =>
      _dbProvider.createCategory(name: name);

  Future<ResponseModel?> createProduct(
          {required int idCategory, required String image}) =>
      _dbProvider.createProduct(idCategory: idCategory, image: image);

  Future<CategorysModel?> getCategorys() => _dbProvider.getCategorys();

  Future<ProductsModel?> getProducts10() => _dbProvider.getProducts10();

  Future<ProductsModel?> getProducts({required int idCategory}) =>
      _dbProvider.getProducts(idCategory: idCategory);
}
