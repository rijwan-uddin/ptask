import 'package:flutter/cupertino.dart';
import 'package:ptask/models/userList.dart';

abstract class MembersInterface {
  void fetchUsers(BuildContext context);  // Accepts token as a parameter
  void displayUsers(List<UserList> users);
}
