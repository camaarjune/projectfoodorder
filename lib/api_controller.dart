import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiController extends GetxController {
  final String baseUrl = 'https://flutter-test-server.onrender.com';

  // Register a new user
  Future<String> registerUser(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/api/users/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        return 'success'; // Return success message
      } else {
        final errorMessage = jsonDecode(response.body)['message'] ?? 'Registration failed';
        return errorMessage; // Return error message from the API
      }
    } catch (e) {
      return 'An error occurred while registering. Please try again.'; // Return generic error message
    }
  }

  // Login an existing user
  Future<String> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/api/users/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return 'success'; // Return success message
      } else if (response.statusCode == 404) {
        return 'This user is not registered.'; // Return specific error message
      } else {
        final errorMessage = jsonDecode(response.body)['message'] ?? 'Login failed';
        return errorMessage; // Return error message from the API
      }
    } catch (e) {
      return 'An error occurred while logging in. Please try again.'; // Return generic error message
    }
  }

  // Add this method to your ApiController
  Future<String> updateUser(String name, String email) async {
    final response = await http.put(
      Uri.parse('${baseUrl}/api/users/update'), // Adjust the endpoint for updating user info
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      return 'success'; // Successful update
    } else {
      return 'Error occurred during update: ${response.body}'; // Other errors
    }
  }
} 