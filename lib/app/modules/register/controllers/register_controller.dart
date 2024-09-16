import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../Services/auth_services.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void onInit() {
    super.onInit();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  bool _validatePassword(String password) {
    String _errorMessage = '';
    if (password.length < 6) {
      _errorMessage += 'Password must be longer than 6 characters.\n';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      _errorMessage += '• Uppercase letter is missing.\n';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      _errorMessage += '• Lowercase letter is missing.\n';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      _errorMessage += '• Digit is missing.\n';
    }
    if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      _errorMessage += '• Special character is missing.\n';
    }
    return _errorMessage.isEmpty;
  }

  Future<void> signUpWithEmailPassword(String email, String password) async {
    isLoading.value = true;
    try {
      User? user = await _auth.registerWithEmailAndPassword(email, password);
      if (user != null) {
        Get.snackbar('Success', 'Successfully Registered',
            backgroundColor: Colors.greenAccent,
            colorText: Colors.white,
            dismissDirection: DismissDirection.up,
            borderRadius: 10,
            duration: Duration(seconds: 5),
            isDismissible: true,
            icon: Icon(
              Icons.login,
              color: Colors.white,
            ));
        Get.offNamed('/home');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  final AuthService _auth = AuthService();
}
