// import 'package:flutter/material.dart';
//
// class GlobalBottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTabTapped;
//
//   const GlobalBottomNavBar({
//     Key? key,
//     required this.currentIndex,
//     required this.onTabTapped,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: onTabTapped,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.task_alt),
//           label: 'My Tasks',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.group),
//           label: 'Others Tasks',
//         ),
//       ],
//     );
//   }
// }
// import 'package:flutter/material.dart';
//
// class GlobalBottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTabTapped;
//
//   const GlobalBottomNavBar({
//     required this.currentIndex,
//     required this.onTabTapped,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: onTabTapped,
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.task),
//           label: 'My Tasks',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.group),
//           label: 'Member Tasks',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.settings),
//           label: 'Settings',
//         ),
//       ],
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:ptask/view/MembersTasks/member_task_screen.dart';
//
//
// class GlobalBottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTabTapped;
//   final String token; // Pass token for MemberTaskScreen
//
//   const GlobalBottomNavBar({
//     required this.currentIndex,
//     required this.onTabTapped,
//     required this.token,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       // onTap: (index) {
//       //   onTabTapped(index);
//       //   if (index == 1) {
//       //     Navigator.push(
//       //       context,
//       //       MaterialPageRoute(
//       //         builder: (context) => MemberTaskScreen(token: token),
//       //       ),
//       //     );
//       //   }
//       // },
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


import '../repository/member_task_repository.dart';

class GlobalBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;
  final String token;


  const GlobalBottomNavBar({
    required this.currentIndex,
    required this.onTabTapped,
    required this.token,

  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) async {
        onTabTapped(index);

        if (index == 1) {
          // Call API when "Members" button is tapped
          try {
            final MemberTaskRepository repository = MemberTaskRepository();
            repository.fetchUserMembers(token: token, payload: {
              'token' : token,
            });


          } catch (e) {
            print('Error fetching users: $e');
          }
        }
      },
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
