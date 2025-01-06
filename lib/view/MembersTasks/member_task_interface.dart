import 'package:ptask/models/task_response.dart';

abstract class MemberTaskInterface {
  Future<List<User>> fetchMemberTasks(String token);
}
