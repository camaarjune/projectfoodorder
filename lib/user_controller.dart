import 'package:get/get.dart';

class UserController extends GetxController {
  var name = ''.obs; // Observable for user's name
  var age = ''.obs; // Observable for user's age
  var birthplace = ''.obs; // Observable for user's birthplace
  var info = ''.obs; // Observable for additional info

  // Method to clear user data
  void clearUserData() {
    name.value = '';
    age.value = '';
    birthplace.value = '';
    info.value = '';
  }
} 