
import 'package:flutter/cupertino.dart';
import 'package:ptask/models/userList.dart';
import 'package:ptask/repository/member_task_repository.dart';
import 'package:ptask/view/MembersTasks/member_task_interface.dart';

class MembersPresenter implements MembersInterface {
  final MembersInterface _view;
  final MemberTaskRepository _repository;

  MembersPresenter(this._view, this._repository);

  @override
  Future<void> fetchUsers(BuildContext context) async {
    try {
      List<UserList> users = await _repository.fetchUserMembers(
          context: context


      );
      _view.displayUsers(users);
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  @override
  void displayUsers(List<UserList> users) {
    // Pass the fetched data to the view
    _view.displayUsers(users);
  }
}
