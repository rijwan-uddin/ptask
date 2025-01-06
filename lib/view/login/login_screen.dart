//
// import 'package:flutter/material.dart';
// import 'package:ptask/utils/custom_widget.dart';
// import 'package:ptask/utils/route_constant.dart';
// import 'package:ptask/view/home_screen.dart';
//
// import 'login_presenter.dart';
// import 'login_interface.dart';
// import '../../utils/toast_utils.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> implements LoginViewInterface {
//   late LoginPresenter presenter;
//   final TextEditingController emailController = TextEditingController(text:'rijwan.uddin@shadhinlab.com');
//   final TextEditingController passwordController = TextEditingController(text:'12345678');
//   final FocusNode emailFocusNode = FocusNode();
//   final FocusNode passwordFocusNode = FocusNode();
//   bool isLoading = false;
//   bool rememberMe = false;
//
//   @override
//   void initState() {
//     super.initState();
//     presenter = LoginPresenter(this);
//   }
//
//   void _login() {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();
//
//     if (!email.contains('@shadhinlab')) {
//       ToastUtils.showToast('Please enter a valid email address');
//       return;
//     }
//
//     if (password.length < 6) {
//       ToastUtils.showToast('Password must be at least 6 characters long');
//       return;
//     }
//
//     if (email.isNotEmpty && password.isNotEmpty) {
//       setState(() {
//         isLoading = true;
//       });
//       presenter.login(email, password);
//     } else {
//       ToastUtils.showToast('Please enter both email and password');
//     }
//   }
//
//   @override
//   void onLoginSuccess(String token, String userId) {
//     setState(() {
//       isLoading = false;
//     });
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => HomeScreen(id: userId, token: token),
//       ),
//     );
//   }
//
//   @override
//   void onLoginError(String error) {
//     setState(() {
//       isLoading = false;
//     });
//     ToastUtils.showToast(error);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CustomLogo(height: 150, width: 150),
//               SizedBox(height: 20),
//               // Email Input
//               CustomTextField(
//                 controller: emailController,
//                 labelText: 'Email',
//                 focusNode: emailFocusNode,
//                 textInputAction: TextInputAction.next,
//                 onSubmitted: (_) {
//                   FocusScope.of(context).requestFocus(passwordFocusNode);
//                 },
//               ),
//               SizedBox(height: 15),
//               // Password Input
//               CustomTextField(
//                 controller: passwordController,
//                 labelText: 'Password',
//                 focusNode: passwordFocusNode,
//                 isPassword: true,
//                 textInputAction: TextInputAction.done,
//                 onSubmitted: (_) => _login(),
//               ),
//               SizedBox(height: 15),
//               // Remember Me Checkbox
//               CustomCheckbox(
//                 value: rememberMe,
//                 onChanged: (value) {
//                   setState(() {
//                     rememberMe = value ?? false;
//                   });
//                 },
//                 label: 'Remember Me',
//               ),
//               SizedBox(height: 20),
//               // Login Button
//               CustomButton(
//                 onPressed: _login,
//                 isLoading: isLoading,
//                 text: 'Login',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:ptask/utils/custom_widget.dart';
import 'package:ptask/utils/route_constant.dart';
import 'package:ptask/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool isLoading = false;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    presenter = LoginPresenter(this);
    _loadCredentials(); // Load saved credentials on app start
  }

  /// Load saved email and password if "Remember Me" was checked
  Future<void> _loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_email') ?? '';
    final savedPassword = prefs.getString('saved_password') ?? '';
    final savedRememberMe = prefs.getBool('remember_me') ?? false;

    setState(() {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      rememberMe = savedRememberMe;
    });
  }

  /// Save email and password to SharedPreferences
  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setString('saved_email', emailController.text);
      await prefs.setString('saved_password', passwordController.text);
      await prefs.setBool('remember_me', true);
    } else {
      await prefs.remove('saved_email');
      await prefs.remove('saved_password');
      await prefs.setBool('remember_me', false);
    }
  }

  void _login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!email.contains('@')) {
      ToastUtils.showToast('Please enter a valid email address');
      return;
    }

    if (password.length < 4) {
      ToastUtils.showToast('Password must be at least 4 characters long');
      return;
    }

    if (email.isNotEmpty && password.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      presenter.login(email, password);
    } else {
      ToastUtils.showToast('Please enter both email and password');
    }
  }

  @override
  void onLoginSuccess(String token, String userId) {
    setState(() {
      isLoading = false;
    });
    _saveCredentials(); // Save credentials after a successful login
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
              CustomLogo(height: 150, width: 150),
              SizedBox(height: 20),
              // Email Input
              CustomTextField(
                controller: emailController,
                labelText: 'Email',
                focusNode: emailFocusNode,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
              ),
              SizedBox(height: 15),
              // Password Input
              CustomTextField(
                controller: passwordController,
                labelText: 'Password',
                focusNode: passwordFocusNode,
                isPassword: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _login(),
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
