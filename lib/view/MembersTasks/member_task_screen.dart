
// import 'package:flutter/material.dart';
// import 'package:ptask/models/userList.dart';
// import 'package:ptask/repository/member_task_repository.dart';
// import 'package:ptask/view/MembersTasks/member_task_interface.dart';
// import 'package:ptask/view/MembersTasks/member_task_presenter.dart';
//
// class MembersScreen extends StatefulWidget {
//   final String token;
//
//   const MembersScreen({Key? key, required this.token}) : super(key: key);
//
//   @override
//   _MembersScreenState createState() => _MembersScreenState();
// }
//
// class _MembersScreenState extends State<MembersScreen> implements MembersInterface {
//   late MembersPresenter _presenter;
//   List<UserList> _userList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _presenter = MembersPresenter(this, MemberTaskRepository());
//     _presenter.fetchUsers(widget.token);
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
//         title: const Text('Members List'),
//       ),
//       body: _userList.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: _userList.length,
//         itemBuilder: (context, index) {
//           final user = _userList[index];
//           print("Rendering user: $user"); // Debugging log
//           return ListTile(
//             title: Text('${user.firstName} ${user.lastName} '),
//             subtitle: Text(user.email ?? 'No email'),
//             // leading: user.photoPath != null
//             //     ? Image.network(user.photoPath!)
//             //     : const Icon(Icons.account_circle),
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   Future<void> fetchUsers(String token) async {
//     // Fetching handled by presenter; no need to implement this here.
//     throw UnimplementedError();
//   }
// }
import 'package:flutter/material.dart';
import 'package:ptask/models/userList.dart';
import 'package:ptask/repository/member_task_repository.dart';
import 'package:ptask/repository/task_repository.dart';
import 'package:ptask/view/MembersTasks/member_task_interface.dart';
import 'package:ptask/view/MembersTasks/member_task_presenter.dart';
import 'package:ptask/view/mytask/task_presenter.dart';

class MembersScreen extends StatefulWidget {
  final String token;

  const MembersScreen({Key? key, required this.token}) : super(key: key);

  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> implements MembersInterface {
  late MembersPresenter _presenter;
  List<UserList> _userList = [];
  late TaskPresenter presenter;
  @override
  void initState() {
    super.initState();
    _presenter = MembersPresenter(this, MemberTaskRepository());
    _presenter.fetchUsers(widget.token);
  }

  @override
  void displayUsers(List<UserList> users) {
    setState(() {
      _userList = users;
      print("UI updated with users: $_userList"); // Debugging log
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Members List',

        ),

      ),
      body: _userList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: _userList.length,
          itemBuilder: (context, index) {
            final user = _userList[index];
            // print("Rendering user: $user"); // Debugging log
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
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                title: Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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


                    // Create an object of TaskRepository
                    TaskRepository taskRepository = TaskRepository();

                    // Use it to fetch tasks for the selected user
                    taskRepository.fetchUserTasks(user.id.toString(), widget.token).then((taskList) {
                      // You can update the UI here with the fetched tasks if needed
                      // For example, you can navigate to a new screen or display a dialog with task details.
                      //data paowar por ,my task e pass korate hbe,
                      print('Fetched tasks: $taskList');

                      // Handle the fetched tasks here, e.g., navigate to a different screen
                    }).catchError((e) {
                      // Handle any error that occurs while fetching tasks
                      print('Error: $e');
                    });


                  // Handle tap if needed
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Future<void> fetchUsers(String token) async {
    // Fetching handled by presenter; no need to implement this here.
    throw UnimplementedError();
  }
}
