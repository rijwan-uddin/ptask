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
import 'package:flutter/material.dart';

class GlobalBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const GlobalBottomNavBar({
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.task),
          label: 'My Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Others Tasks',
        ),
      ],
    );
  }
}
