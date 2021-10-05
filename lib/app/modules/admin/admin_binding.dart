import 'package:get/get.dart';

import 'admin_logic.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminLogic());
  }
}
