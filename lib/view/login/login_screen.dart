// import 'package:flutter/material.dart';
// import 'package:ptask/utils/custom_widget.dart';
//
// import 'package:ptask/view/home_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
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
// class _LoginScreenState extends State<LoginScreen>
//     implements LoginViewInterface {
//   late LoginPresenter presenter;
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final FocusNode emailFocusNode = FocusNode();
//   final FocusNode passwordFocusNode = FocusNode();
//   bool isLoading = false;
//   bool rememberMe = false;
//
//   @override
//   void initState() {
//     super.initState();
//     presenter = LoginPresenter(this);
//     _loadCredentials(); // Load saved credentials on app start
//   }
//
//   /// Load saved email and password if "Remember Me" was checked
//   Future<void> _loadCredentials() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedEmail = prefs.getString('saved_email') ?? '';
//     final savedPassword = prefs.getString('saved_password') ?? '';
//     final savedRememberMe = prefs.getBool('remember_me') ?? false;
//
//     setState(() {
//       emailController.text = savedEmail;
//       passwordController.text = savedPassword;
//       rememberMe = savedRememberMe;
//     });
//   }
//
//   /// Save email and password to SharedPreferences
//   Future<void> _saveCredentials() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (rememberMe) {
//       await prefs.setString('saved_email', emailController.text);
//       await prefs.setString('saved_password', passwordController.text);
//       await prefs.setBool('remember_me', true);
//     } else {
//       await prefs.remove('saved_email');
//       await prefs.remove('saved_password');
//       await prefs.setBool('remember_me', false);
//     }
//   }
//
//   Future<void> _checkConnectivityAndLogin() async {
//     // Check for network connectivity
//     final connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       ToastUtils.showToast('Please check internet connection and try again');
//       return;
//     }
//
//     // If connected, perform login
//     _login();
//   }
//
//   void _login() {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();
//
//     if (!email.contains('@')) {
//       ToastUtils.showToast('Please enter a valid email address');
//       return;
//     }
//
//     if (password.length < 4) {
//       ToastUtils.showToast('Password must be at least 4 characters long');
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
//     _saveCredentials(); // Save credentials after a successful login
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
//                 keyboardType: TextInputType.emailAddress,
//                 textInputAction: TextInputAction.next,
//                 onSubmitted: (_) {
//                   FocusScope.of(context).requestFocus(passwordFocusNode);
//                 },
//               ),
//               SizedBox(height: 15),
//               CustomTextField(
//                 controller: passwordController,
//                 labelText: 'Password',
//                 focusNode: passwordFocusNode,
//                 isPassword: true,
//                 textInputAction: TextInputAction.done,
//                 onSubmitted: (_) => _checkConnectivityAndLogin(),
//                 keyboardType: TextInputType.visiblePassword,
//               ),
//
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
//                 onPressed: _checkConnectivityAndLogin,
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
///
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:ptask/view/home_screen.dart';
// import '../../utils/toast_utils.dart';
// import 'login_presenter.dart';
// import 'login_interface.dart';
// import '../../utils/custom_widget.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> implements LoginViewInterface {
//   late LoginPresenter presenter;
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final FocusNode emailFocusNode = FocusNode();
//   final FocusNode passwordFocusNode = FocusNode();
//   bool isLoading = false;
//   bool rememberMe = false;
//
//   @override
//   void initState() {
//     super.initState();
//     presenter = LoginPresenter(this);
//     _checkLoginStatus(); // Check if the user is already logged in
//     _loadCredentials(); // Load saved credentials for autofill
//   }
//
//   /// Check if user is already logged in
//   Future<void> _checkLoginStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('auth_token');
//     final userId = prefs.getString('user_id');
//
//     if (token != null && userId != null) {
//       // User is already logged in; navigate to HomeScreen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomeScreen(id: userId, token: token),
//         ),
//       );
//     }
//   }
//
//   /// Load saved email and password if "Remember Me" was checked
//   Future<void> _loadCredentials() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedEmail = prefs.getString('saved_email') ?? '';
//     final savedPassword = prefs.getString('saved_password') ?? '';
//     final savedRememberMe = prefs.getBool('remember_me') ?? false;
//
//     setState(() {
//       emailController.text = savedEmail;
//       passwordController.text = savedPassword;
//       rememberMe = savedRememberMe;
//     });
//   }
//
//   /// Save email, password, and login session to SharedPreferences
//   Future<void> _saveLoginSession(String token, String userId) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('auth_token', token);
//     await prefs.setString('user_id', userId);
//
//     if (rememberMe) {
//       await prefs.setString('saved_email', emailController.text);
//       await prefs.setString('saved_password', passwordController.text);
//       await prefs.setBool('remember_me', true);
//     } else {
//       await prefs.remove('saved_email');
//       await prefs.remove('saved_password');
//       await prefs.setBool('remember_me', false);
//     }
//   }
//
//   Future<void> _checkConnectivityAndLogin() async {
//     // Check for network connectivity
//     final connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       ToastUtils.showToast('Please check internet connection and try again');
//       return;
//     }
//
//     // If connected, perform login
//     _login();
//   }
//
//   void _login() {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();
//
//     if (!email.contains('@')) {
//       ToastUtils.showToast('Please enter a valid email address');
//       return;
//     }
//
//     if (password.length < 4) {
//       ToastUtils.showToast('Password must be at least 4 characters long');
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
//     _saveLoginSession(token, userId); // Save login session after successful login
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
//               CustomTextField(
//                 controller: emailController,
//                 labelText: 'Email',
//                 focusNode: emailFocusNode,
//                 keyboardType: TextInputType.emailAddress,
//                 textInputAction: TextInputAction.next,
//                 onSubmitted: (_) {
//                   FocusScope.of(context).requestFocus(passwordFocusNode);
//                 },
//               ),
//               SizedBox(height: 15),
//               CustomTextField(
//                 controller: passwordController,
//                 labelText: 'Password',
//                 focusNode: passwordFocusNode,
//                 isPassword: true,
//                 textInputAction: TextInputAction.done,
//                 onSubmitted: (_) => _checkConnectivityAndLogin(),
//                 keyboardType: TextInputType.visiblePassword,
//               ),
//               SizedBox(height: 15),
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
//               CustomButton(
//                 onPressed: _checkConnectivityAndLogin,
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ptask/view/home_screen.dart';
import '../../utils/toast_utils.dart';
import 'login_presenter.dart';
import 'login_interface.dart';
import '../../utils/custom_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginViewInterface {
  late LoginPresenter presenter;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool isLoading = false;
  bool rememberMe = false;

  late Future<bool> _checkLoginFuture;

  @override
  void initState() {
    super.initState();
    presenter = LoginPresenter(this);
    _checkLoginFuture = _checkLoginStatus(); // Start checking login status on initialization
    _loadCredentials(); // Load saved credentials for autofill
  }

  /// Check if user is already logged in
  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final userId = prefs.getString('user_id');

    if (token != null && userId != null) {
      // User is already logged in; navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(id: userId),
        ),
      );
      return true;
    }
    return false; // User is not logged in
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

  /// Save email, password, and login session to SharedPreferences
  Future<void> _saveLoginSession(String token, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('user_id', userId);

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

  Future<void> _checkConnectivityAndLogin() async {
    // Check for network connectivity
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      ToastUtils.showToast('Please check internet connection and try again');
      return;
    }

    // If connected, perform login
    _login();
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
    _saveLoginSession(token, userId); // Save login session after successful login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(id: userId),
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
    return FutureBuilder<bool>(
      future: _checkLoginFuture,
      builder: (context, snapshot) {
        // Show loading indicator while checking login status
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If login status check is complete, show login screen
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
                  CustomTextField(
                    controller: emailController,
                    labelText: 'Email',
                    focusNode: emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) {
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    controller: passwordController,
                    labelText: 'Password',
                    focusNode: passwordFocusNode,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _checkConnectivityAndLogin(),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 15),
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
                  CustomButton(
                    onPressed: _checkConnectivityAndLogin,
                    isLoading: isLoading,
                    text: 'Login',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
