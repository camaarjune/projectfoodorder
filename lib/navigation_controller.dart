import 'package:get/get.dart';

class NavigationController extends GetxController {
  // Define your navigation methods here
  void goToHome() {
    Get.offAllNamed('/home'); // Ensure this route is defined in your GetX routing
  }

  void goToLogin() {
    Get.offAllNamed('/login'); // Navigate to Login screen
  }

  void goToSignup() {
    Get.offAllNamed('/signup'); // Navigate to Signup screen
  }
} 