import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:notesapplication/Core/globalLoaderWithLogo.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  final GlobalKey<FormState> signUpFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DoublePressBackWidget(
        message: "Press back again to exit",
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF1d2630),
              foregroundColor: Colors.white,
            ),
            body: Obx(
              () => GlobalLoader.build(
                isLoading: controller.isLoading.value,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: signUpFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            'Welcome to Notes App',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextField(
                            controller: controller.emailCont,
                            focus: controller.emailFocus,
                            nextFocus: controller.passwordFocus,
                            textFieldType: TextFieldType.EMAIL,
                            textStyle: TextStyle(color: Colors.grey),
                            validator: (value) {
                              return controller.validateEmail(value!);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 47, 46, 46)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: grey),
                              ),
                              labelText: 'Email',
                              labelStyle: const TextStyle(color: grey),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextField(
                            controller: controller.passwordCont,
                            focus: controller.passwordFocus,
                            textFieldType: TextFieldType.PASSWORD,
                            isValidationRequired: true,
                            textStyle: TextStyle(color: Colors.grey),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 47, 46, 46)),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: grey)),
                                labelText: 'Password',
                                labelStyle: const TextStyle(color: grey)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.signUpWithEmailPassword(
                                  controller.emailCont.text,
                                  controller.passwordCont.text);
                              // if (signUpFormKey.currentState!.validate()) {
                              //   print('VALID');
                              //   // controller.signUpWithEmailPassword(
                              //   //     controller.emailCont.text,
                              //   //     controller.passwordCont.text);
                              // }
                            },
                            child: const Text('Register'),
                            style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.blue),
                            ),
                            autofocus: true,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          loginAccount(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }

  Widget loginAccount() {
    return Column(
      children: [
        Text('Already have account login'),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              Get.toNamed('/login');
            },
            child: Text('Login'))
      ],
    );
  }
}
