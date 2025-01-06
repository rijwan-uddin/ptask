import 'package:ptask/models/userList.dart';

abstract class MembersInterface {
  void fetchUsers(String token);  // Accepts token as a parameter
  void displayUsers(List<UserList> users);
}
