
import 'package:flutter/material.dart';
import 'package:ptask/view/home_screen.dart';
import 'package:ptask/view/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProTask',
      initialRoute: '/',
      routes: {
        '/': (context) =>LoginScreen(),
        '/home': (context) => HomeScreen(userId: '', token: '',),
      },
    );
  }
}
