import 'package:get/get.dart';
import 'package:master_champions/utils/encrypt_helper.dart';

class DependencyInjection {
  static void init() {
    Get.put<EncryptHelper>(EncryptHelper());
    //Get.put<LocalDataProvider>(LocalDataProvider());
    //Get.put<LocalDataRepository>(LocalDataRepository());
  }
}