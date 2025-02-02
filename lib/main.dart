import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'navigation_controller.dart'; // Import the NavigationController
import 'home_screen.dart'; // Import HomeScreen
import 'login_screen.dart'; // Import LoginScreen
import 'signup_screen.dart'; // Import SignupScreen

void main() {
  // Register the NavigationController
  Get.put(NavigationController());
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/login', // Set the initial route
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/signup', page: () => SignupScreen()),
      ],
    );
  }
}
