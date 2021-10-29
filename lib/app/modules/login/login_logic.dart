import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_champions/app/data/repositorys/db_repository.dart';
import 'package:master_champions/app/data/services/auth_service.dart';
import 'package:master_champions/app/routes/app_pages.dart';

class LoginLogic extends GetxController {
  final _dataRepository = Get.find<DbRepository>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  String? validateEmail(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return (!regex.hasMatch(value ?? '')) ? 'Ingrese su correo' : null;
  }

  String? isNotEmpty(String? text) {
    if (text != null) if (text.isNotEmpty) return null;
    return 'Ingrese su contraseña';
  }

  void _dialogLoading() {
    Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: const Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                strokeWidth: 10,
              ),
            ),
          ),
        ),
        barrierDismissible: false);
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      _dialogLoading();
      final userModel = await _dataRepository.login(
          //email: 'bankenro.myhope@gmail.com', password: '31en02fe24ma',
          user: emailCtrl.text.trim(),
          password: passCtrl.text.trim());
      Get.back();
      if (userModel != null) {
        await AuthService.to.login(userModel.login[0].id.toString());
        Get.rootDelegate.offNamed(Routes.home);
      }
    }
  }
}
