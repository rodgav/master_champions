import 'package:get/get.dart';
import 'package:master_champions/app/routes/app_pages.dart';

class RootLogic extends GetxController {
  void goHome() {
    Get.rootDelegate.toNamed(Routes.home);
  }
}
