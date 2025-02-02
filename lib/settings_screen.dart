import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import the LoginScreen
import 'package:get/get.dart';
import 'user_controller.dart'; // Import the UserController

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final UserController userController = Get.put(UserController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController birthplaceController = TextEditingController();
  final TextEditingController infoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with user information from the UserController
    nameController.text = userController.name.value;
    ageController.text = userController.age.value;
    birthplaceController.text = userController.birthplace.value;
    infoController.text = userController.info.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.red),
            onPressed: () {
              _confirmLogout(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User Information', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildTextField(Icons.person, 'Name', nameController),
              SizedBox(height: 16),
              _buildTextField(Icons.calendar_today, 'Age', ageController),
              SizedBox(height: 16),
              _buildTextField(Icons.location_on, 'Birthplace', birthplaceController),
              SizedBox(height: 16),
              _buildTextField(Icons.info, 'Additional Info', infoController),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Save user information to the UserController
                  userController.name.value = nameController.text;
                  userController.age.value = ageController.text;
                  userController.birthplace.value = birthplaceController.text;
                  userController.info.value = infoController.text;

                  Get.snackbar('Success', 'User information saved successfully');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Save', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blue),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                userController.clearUserData(); // Clear user data on logout
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to LoginScreen
                );
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}