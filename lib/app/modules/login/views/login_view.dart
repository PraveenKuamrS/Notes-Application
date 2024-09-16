import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:notesapplication/Core/toast.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final AlertService _alertService = AlertService();
  final GlobalKey<FormState> SignInKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            loginForm(context),
          ],
        ),
      )),
    );
  }

  Widget loginForm(BuildContext context) {
    return Form(
        key: SignInKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            AppTextField(
              textFieldType: TextFieldType.EMAIL,
              autoFocus: true,
              controller: controller.emailcont,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: grey),
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: grey),
              ),
              errorInvalidEmail: 'Please check your mail!',
              validator: (value) {
                return controller.validateEmail(value!);
              },
              isValidationRequired: true,
              textStyle: TextStyle(color: grey),
            ),
            SizedBox(
              height: 20,
            ),
            AppTextField(
              textFieldType: TextFieldType.PASSWORD,
              autoFocus: true,
              controller: controller.password,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: grey),
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: grey),
              ),
              isPassword: true,
              isValidationRequired: true,
              textStyle: TextStyle(color: grey),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (SignInKey.currentState!.validate()) {
                    var user = await controller.login(
                        controller.emailcont.text, controller.password.text);
                    print(user);
                    if (user == null) {
                      Get.snackbar('Warning', 'Invalid Creadentials',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          dismissDirection: DismissDirection.up,
                          borderRadius: 10,
                          duration: Duration(seconds: 3),
                          isDismissible: true,
                          icon: Icon(
                            Icons.warning_rounded,
                            color: Colors.white,
                          ));
                    } else {
                      Get.snackbar('Success', 'Successfully LoggedIn',
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
                  }
                },
                autofocus: true,
                style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(
                        const Color.fromARGB(255, 9, 236, 236))),
                child: Text(
                  'Login',
                  style: TextStyle(),
                ))
          ],
        ));
  }
}
