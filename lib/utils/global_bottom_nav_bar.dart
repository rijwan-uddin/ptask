//
// import 'package:flutter/material.dart';
// import 'package:ptask/repository/member_task_repository.dart';
//
// class GlobalBottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTabTapped;
//   final String token;
//
//   const GlobalBottomNavBar({
//     Key? key,
//     required this.currentIndex,
//     required this.onTabTapped,
//     required this.token,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: (index) async {
//         onTabTapped(index);
//
//         if (index == 1) {
//           try {
//             final MemberTaskRepository repository = MemberTaskRepository();
//             final users = await repository.fetchUserMembers(token: token, payload: {'token': token});
//             print("Fetched users from bottom nav: $users"); // Debugging log
//           } catch (e) {
//             print('Error fetching users: $e');
//           }
//         }
//       },
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.task),
//           label: 'My Tasks',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.group),
//           label: 'Members',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.settings),
//           label: 'Settings',
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:ptask/view/settings/my_settings.dart';


class GlobalBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;
  final String token;

  const GlobalBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTabTapped,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.task),
          label: 'My Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Members',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}

