
import 'package:flutter/material.dart';
import 'package:ptask/models/userList.dart';
import 'package:ptask/repository/member_task_repository.dart';
import 'package:ptask/view/MembersTasks/member_task_interface.dart';
import 'package:ptask/view/MembersTasks/member_task_presenter.dart';

class MembersScreen extends StatefulWidget {
  final String token;

  const MembersScreen({Key? key, required this.token}) : super(key: key);

  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> implements MembersInterface {
  late MembersPresenter _presenter;
  List<UserList> _userList = [];

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
        title: const Text('Members List'),
      ),
      body: _userList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _userList.length,
        itemBuilder: (context, index) {
          final user = _userList[index];
          print("Rendering user: $user"); // Debugging log
          return ListTile(
            title: Text('${user.firstName} ${user.lastName} '),
            subtitle: Text(user.email ?? 'No email'),
            // leading: user.photoPath != null
            //     ? Image.network(user.photoPath!)
            //     : const Icon(Icons.account_circle),
          );
        },
      ),
    );
  }

  @override
  Future<void> fetchUsers(String token) async {
    // Fetching handled by presenter; no need to implement this here.
    throw UnimplementedError();
  }
}
