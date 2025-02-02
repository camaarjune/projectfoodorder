import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api_controller.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
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
              'Sign Up',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),
            Icon(
              Icons.fastfood,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter your name',
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
                if (nameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Please fill in all fields',
                    backgroundColor: Colors.red, // Red background for errors
                    colorText: Colors.white, // White text for errors
                  );
                } else {
                  String result = await apiController.registerUser(
                    nameController.text,
                    emailController.text,
                    passwordController.text,
                  );
                  if (result == 'success') {
                    Get.snackbar(
                      'Success',
                      'Registration was successful!',
                      backgroundColor: Colors.green, // Green background for success
                      colorText: Colors.white, // White text for success
                    );
                    Get.offAll(() => LoginScreen()); // Navigate to login screen
                  } else {
                    Get.snackbar(
                      'Error',
                      result,
                      backgroundColor: Colors.red, // Red background for errors
                      colorText: Colors.white, // White text for errors
                    );
                  }
                }
              },
              child: Text('Sign Up', style: TextStyle(fontSize: 18, color: Colors.blue)),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.to(() => LoginScreen());
              },
              child: Text(
                'Already have an account? Login',
                style: TextStyle(color: Colors.white), // Set text color to white
              ),
            ),
          ],
        ),
      ),
    );
  }
}