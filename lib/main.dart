
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
// import 'package:flutter/material.dart';
// import 'package:ptask/utils/route_constant.dart';
// import 'package:ptask/view/home_screen.dart';
// import 'package:ptask/view/login/login_screen.dart';
//
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'ProTask',
//       initialRoute: '/',
//       onGenerateRoute: (settings) {
//         if (settings.name == RouteConstants.home) {
//           final args = settings.arguments as Map<String, dynamic>;
//           return MaterialPageRoute(
//             builder: (_) => HomeScreen(
//               userId: args['userId'] ?? '',
//               token: args['token'] ?? '',
//             ),
//           );
//         }
//         return MaterialPageRoute(builder: (_) => LoginScreen());
//       },
//     );
//   }
// }
