import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notesapplication/Core/getStorage.dart';
import 'package:notesapplication/Core/internetConnectivity.dart';
import 'package:notesapplication/Services/auth_services.dart';
import 'package:notesapplication/Services/todoServices.dart';
import 'package:notesapplication/models/todo_model.dart';

class HomeController extends GetxController {
  // Reactive observables in GetX
  final buttonIndex = 0.obs;
  var currentUser = ''.obs; // Use .obs for reactivity
  var uid = ''.obs; // Use .obs for reactivity
  var isInternetConnected = false.obs; // Use .obs for reactive boolean

  final FirebaseAuth user = FirebaseAuth.instance;
  final AuthService _authService = AuthService();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DatabaseServices _databaseServices = DatabaseServices();

  @override
  void onInit() {
    super.onInit();
    print('CALLED IN HOME CONTROLLER');
    currentUser.value = user.currentUser!.email!;
    uid.value = user.currentUser!.uid;
    checkConnection();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Check internet connection using GetX's reactive state management
  Future<void> checkConnection() async {
    bool result = await isInternetConnectedGlobal();
    isInternetConnected.value = result; // Update the reactive variable
  }

  Future<void> logout() async {
    await _authService.signOut(); // Just call the method without assigning
    print("User logged out successfully");
    Get.offAllNamed('/login');
  }

  checkAnyDataAvailableInLocalStorage() {
    var data = getValurFromLocal('SAVEDATAFROMLOCAL');
    print('getValurFromLocal $data');
  }
}
