
import 'package:flutter/material.dart';
import 'package:ptask/utils/custom_widget.dart';
import 'package:ptask/utils/route_constant.dart';
import 'package:ptask/view/home_screen.dart';

import 'login_presenter.dart';
import 'login_interface.dart';
import '../../utils/toast_utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginViewInterface {
  late LoginPresenter presenter;
  final TextEditingController emailController = TextEditingController(text:'rijwan.uddin@shadhinlab.com');
  final TextEditingController passwordController = TextEditingController(text:'12345678');
  bool isLoading = false;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    presenter = LoginPresenter(this);
  }

  void _login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      presenter.login(email, password);
    } else {
      ToastUtils.showToast('Please enter both email and password');
    }
  }

  // @override
  // void onLoginSuccess(String token, String userId) {
  //   setState(() {
  //     isLoading = false;
  //   });
  //   Navigator.pushReplacementNamed(
  //     context,
  //     RouteConstants.home,
  //     arguments: {'userId': userId, 'token': token},
  //   );
  // }
  @override
  void onLoginSuccess(String token, String userId) {
    setState(() {
      isLoading = false;
    });
    print('onLoginSuccess: $token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(id: userId, token: token),
      ),
    );
  }


  @override
  void onLoginError(String error) {
    setState(() {
      isLoading = false;
    });
    ToastUtils.showToast(error);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              CustomLogo(height: 150, width: 150),
              SizedBox(height: 20),
              // Email Input
              CustomTextField(
                controller: emailController,
                labelText: 'Email',

              ),
              SizedBox(height: 15),
              // Password Input
              CustomTextField(
                controller: passwordController,
                labelText: 'Password',
                isPassword: true,
              ),
              SizedBox(height: 15),
              // Remember Me Checkbox
              CustomCheckbox(
                value: rememberMe,
                onChanged: (value) {
                  setState(() {
                    rememberMe = value ?? false;
                  });
                },
                label: 'Remember Me',
              ),
              SizedBox(height: 20),
              // Login Button
              CustomButton(
                onPressed: _login,
                isLoading: isLoading,
                text: 'Login',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
