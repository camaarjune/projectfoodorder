import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api_controller.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiController apiController = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Icon(
              Icons.fastfood,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.green, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter your password',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.green, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              onPressed: () async {
                if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Please fill in all fields',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                } else {
                  String result = await apiController.loginUser(emailController.text, passwordController.text);
                  if (result == 'success') {
                    // Navigate to HomeScreen after successful login
                    Get.offAllNamed('/home');
                  } else {
                    Get.snackbar(
                      'Error',
                      result,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    ); // Show the error message returned from the API
                  }
                }
              },
              child: Text('Login', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.to(() => SignupScreen());
              },
              child: Text(
                'Don\'t have an account? Sign up',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}