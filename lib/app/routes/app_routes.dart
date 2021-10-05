part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const login = _Paths.login;

  static String loginThen(String afterSuccessFullLogin) =>
      '$login?then=${Uri.encodeQueryComponent(afterSuccessFullLogin)}';
  static const admin = _Paths.admin;
}

abstract class _Paths {
  static const home = '/home';
  static const login = '/login';
  static const admin = '/admin';
}
