// import 'package:flutter/material.dart';
// import 'package:ptask/models/userList.dart';
// import 'package:ptask/repository/member_task_repository.dart';
//
// import 'package:ptask/view/MembersTasks/member_task_interface.dart';
// import 'package:ptask/view/MembersTasks/member_task_presenter.dart';
// import 'package:ptask/view/mytask/mytask_screen.dart';
// import 'package:ptask/view/mytask/task_presenter.dart';
//
// class MembersScreen extends StatefulWidget {
//
//
//   const MembersScreen({Key? key}) : super(key: key);
//
//   @override
//   _MembersScreenState createState() => _MembersScreenState();
// }
//
// class _MembersScreenState extends State<MembersScreen>
//     implements MembersInterface {
//   late MembersPresenter _presenter;
//   List<UserList> _userList = [];
//   late TaskPresenter presenter;
//
//   @override
//   void initState() {
//     super.initState();
//     _presenter = MembersPresenter(this, MemberTaskRepository());
//     _presenter.fetchUsers(context);
//   }
//
//   @override
//   void displayUsers(List<UserList> users) {
//     setState(() {
//       _userList = users;
//       print("UI updated with users: $_userList"); // Debugging log
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Members List',
//         ),
//       ),
//       body: _userList.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: ListView.builder(
//                 itemCount: _userList.length,
//                 itemBuilder: (context, index) {
//                   final user = _userList[index];
//                   // print("Rendering user: $user"); // Debugging log
//                   return Card(
//                     elevation: 4.0,
//                     margin: const EdgeInsets.symmetric(vertical: 4.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: ListTile(
//                       contentPadding: const EdgeInsets.all(16.0),
//                       leading: CircleAvatar(
//                         radius: 30.0,
//                         backgroundColor: Colors.blueAccent,
//                         child: Text(
//                           user.firstName?.substring(0, 1) ?? '',
//                           style: const TextStyle(
//                               color: Colors.white, fontSize: 20),
//                         ),
//                       ),
//                       title: Text(
//                         '${user.firstName} ${user.lastName}',
//                         style: const TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Text(
//                         user.position ?? 'Not defined',
//                         style: const TextStyle(color: Colors.grey),
//                       ),
//                       trailing: Icon(
//                         Icons.arrow_forward_ios,
//                         color: Colors.blueAccent,
//                       ),
//                       onTap: () {
//                         // Convert user.id to String and pass it along with the token
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => MyTasksScreen(
//                               userId: user.id?.toString() ?? '',
//                               // Convert num? to String, fallback to an empty string
//                               // Pass the token
//                             ),
//                           ),
//                         );
//
//                         // Handle tap if needed
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//     );
//   }
//
//   @override
//   Future<void> fetchUsers(BuildContext context) async {
//     // Fetching handled by presenter; no need to implement this here.
//     throw UnimplementedError();
//   }
// }
///
/// last
import 'package:flutter/material.dart';
import 'package:ptask/models/userList.dart';
import 'package:ptask/repository/member_task_repository.dart';
import 'package:ptask/view/mytask/mytask_screen.dart';
import 'package:ptask/view/MembersTasks/member_task_presenter.dart';
import 'package:ptask/view/MembersTasks/member_task_interface.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({Key? key}) : super(key: key);

  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen>
    implements MembersInterface {
  late MembersPresenter _presenter;
  List<UserList> _userList = [];

  @override
  void initState() {
    super.initState();
    _presenter = MembersPresenter(this, MemberTaskRepository());
    _presenter.fetchUsers(context);
  }

  @override
  void displayUsers(List<UserList> users) {
    setState(() {
      _userList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members List'),
      ),
      body: _userList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: _userList.length,
          itemBuilder: (context, index) {
            final user = _userList[index];
            return Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.blueAccent,
                  child: Text(
                    user.firstName?.substring(0, 1) ?? '',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 20),
                  ),
                ),
                title: Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  user.position ?? 'Not defined',
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blueAccent,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyTasksScreen(
                        userId: user.id?.toString() ?? '',
                        userName: '${user.firstName} ${user.lastName}', // Pass the user name
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Future<void> fetchUsers(BuildContext context) async {
    // Fetching handled by presenter; no need to implement this here.
    throw UnimplementedError();
  }
}
