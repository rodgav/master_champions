import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_champions/app/data/services/auth_service.dart';
import 'package:master_champions/app/routes/app_pages.dart';
import 'package:master_champions/utils/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      initialBinding: BindingsBuilder(() {
        Get.put(AuthService());
      }),
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Master Champions',
      getPages: AppPages.routes,
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {PointerDeviceKind.touch, PointerDeviceKind.mouse};
}