//
// import 'package:flutter/material.dart';
// import 'package:ptask/view/MembersTasks/member_task_screen.dart';
// import 'package:ptask/view/mytask/mytask_screen.dart';
// import '../../utils/global_bottom_nav_bar.dart';
//
// class HomeScreen extends StatefulWidget {
//   final String id;
//   final String token;
//
//   const HomeScreen({Key? key, required this.id, required this.token}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//
//   late List<Widget> _pages;
//
//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//       MyTasksScreen(userId: widget.id, token: widget.token), // First tab
//       MembersScreen(token: widget.token), // Second tab
//     ];
//   }
//
//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex],
//       bottomNavigationBar: GlobalBottomNavBar(
//         currentIndex: _currentIndex,
//         onTabTapped: _onTabTapped,
//         token: widget.token,
//       ),
//     );
//   }
// }
//
//
import 'package:flutter/material.dart';
import 'package:ptask/view/MembersTasks/member_task_screen.dart';
import 'package:ptask/view/mytask/mytask_screen.dart';
import 'package:ptask/view/settings/my_settings.dart';

import '../../utils/global_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  final String id;
  final String token;

  const HomeScreen({Key? key, required this.id, required this.token}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      MyTasksScreen(userId: widget.id, token: widget.token), // First tab
      MembersScreen(token: widget.token), // Second tab
      SettingsScreen(), // Settings page for the third tab
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: GlobalBottomNavBar(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
        token: widget.token,
      ),
    );
  }
}
