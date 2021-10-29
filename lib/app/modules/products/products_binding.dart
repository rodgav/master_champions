import 'package:get/get.dart';

import 'products_logic.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsLogic());
  }
}
