import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapplication/Core/toast.dart';
import 'package:notesapplication/Services/auth_services.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final AlertService _alertService = AlertService();

  final count = 0.obs;
  final AuthService _authService = AuthService();
  TextEditingController emailcont = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email address';
    } else {}
  }

  void increment() => count.value++;

  login(email, password) async {
    User? user = await _authService.signInWithEmailAndPassword(email, password);
    print(user);
    return user;
    // if (user == null) {
    //   // Get.snackbar('Invalid credentual', message)
    //   _alertService.showToast(text: "Invalid Credentials", color: Colors.red);
    // } else {
    //   user != null ? Get.offNamed('/home') : null;
    // }
  }
}
