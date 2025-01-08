import 'package:http/http.dart' as http;
import 'package:ptask/utils/app_constant.dart';
import 'dart:convert';
import 'login_interface.dart';

class LoginPresenter {
  final LoginViewInterface view;

  LoginPresenter(this.view);

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${AppConstant.baseUrl}/signin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Extract the user ID
        final int userId = data['user']['id'];

        print('User ID: $userId');

        var email = data['user']['email'];
        // print('email : $email');
        //
        // print('data: $data');
        String token = data['token'];

        view.onLoginSuccess(token, '$userId');
      } else {
        view.onLoginError('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('$e');
      view.onLoginError('An error occurred: $e');
    }
  }
}
