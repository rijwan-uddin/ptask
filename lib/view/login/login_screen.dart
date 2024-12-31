import 'package:flutter/material.dart';
import '../../utils/tools.dart';
import '../../utils/custom_widget.dart';
import '../../utils/toast_utils.dart';
import '../../repository/login_repository.dart';
import 'login_presenter.dart';
import 'login_interface.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginViewInterface {
  late LoginPresenter presenter;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    presenter = LoginPresenter(LoginRepository(), this);
  }

  @override
  void onLoginSuccess(String token) {
    setState(() {
      isLoading = false;
    });
    ToastUtils.showToast('Login successful!');
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void onLoginError(String error) {
    setState(() {
      isLoading = false;
    });
    ToastUtils.showToast(error);
  }

  void _handleLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ToastUtils.showToast('Please fill in all fields');
      return;
    }

    setState(() {
      isLoading = true;
    });

    presenter.signIn(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomWidgets.customTextField(
              controller: emailController,
              hintText: 'Email',

            ),
            SizedBox(height: 16),
            CustomWidgets.customTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            SizedBox(height: 16),
            CustomWidgets.customButton(
              text: isLoading ? 'Loading...' : 'Sign In',
              onPressed: isLoading ? null : _handleLogin,
            ),
          ],
        ),
      ),
    );
  }
}
