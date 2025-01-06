// import 'package:ptask/models/task_response.dart';
// import 'package:ptask/repository/member_task_repository.dart';
//
//
//
// class MemberTaskPresenter {
//   final MemberTaskRepository _repository;
//
//   MemberTaskPresenter(this._repository);
//
//   Future<List<User>> getMemberTasks(String token) async {
//     try {
//       return await _repository.fetchMemberTasks(token);
//     } catch (e) {
//       print('Error in Presenter: $e');
//       throw Exception("Failed to get member tasks: $e");
//     }
//   }
// }
