import 'package:get/get.dart';
import 'package:master_champions/app/core/utils/helpers/encrypt_helper.dart';
import 'package:master_champions/app/data/providers/db_provider.dart';
import 'package:master_champions/app/data/repositorys/db_repository.dart';

import 'http/http.dart';

class DependencyInjection {
  static void init() {
    final _http = Http();
    Get.put<EncryptHelper>(EncryptHelper());
    Get.put<DbProvider>(DbProvider(_http));
    Get.put<DbRepository>(DbRepository());
  }
}