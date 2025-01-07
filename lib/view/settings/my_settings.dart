import 'package:flutter/material.dart';
import 'package:ptask/view/login/login_screen.dart';


class SettingsScreen extends StatelessWidget {

  Future<void> _logout(BuildContext context) async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('saved_email');
    // await prefs.remove('saved_password');
    // await prefs.setBool('remember_me', false);

    // Clear the navigation stack and navigate to the LoginScreen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false, // This prevents the user from navigating back
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center( // Center the entire body content
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Other settings content can go here
              SizedBox(height: 40),
              // Logout Button
              ElevatedButton(
                onPressed: () => _logout(context),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1877F2), // Facebook blue color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
