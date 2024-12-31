
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_interface.dart';

class LoginPresenter {
  final LoginViewInterface view;

  LoginPresenter(this.view);

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://protask.shadhintech.com/api/signin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          String token = data['data']['token']; // Assuming the token is here
          String userId = data['data']['id'].toString(); // Assuming the userId is here
          view.onLoginSuccess(token, userId);
        } else {
          view.onLoginError(data['message'] ?? 'Login failed');
        }
      } else {
        view.onLoginError('Error: ${response.statusCode}');
      }
    } catch (e) {
      view.onLoginError('An error occurred: $e');
    }
  }
}
