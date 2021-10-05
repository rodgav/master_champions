import 'package:get/get.dart';
import 'package:master_champions/app/data/middlewares/auth_middleware.dart';
import 'package:master_champions/app/modules/admin/admin_binding.dart';
import 'package:master_champions/app/modules/admin/admin_view.dart';
import 'package:master_champions/app/modules/home/home_binding.dart';
import 'package:master_champions/app/modules/home/home_view.dart';
import 'package:master_champions/app/modules/login/login_binding.dart';
import 'package:master_champions/app/modules/login/login_view.dart';
import 'package:master_champions/app/modules/root/root_binding.dart';
import 'package:master_champions/app/modules/root/root_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;
  static final routes = [
    GetPage(
        name: '/',
        page: () => RootPage(),
        binding: RootBinding(),
        participatesInRootNavigator: true,
        preventDuplicates: true,
        children: [
          GetPage(
              preventDuplicates: true,
              name: _Paths.home,
              page: () => HomePage(),
              binding: HomeBinding()),
          GetPage(
              preventDuplicates: true,
              middlewares: [EnsureNotAuthMiddleware()],
              name: _Paths.login,
              page: () => LoginPage(),
              binding: LoginBinding()),
          GetPage(
              preventDuplicates: true,
              middlewares: [EnsureAuthMiddleware()],
              name: _Paths.admin,
              page: () => AdminPage(),
              binding: AdminBinding())
        ])
  ];
}
