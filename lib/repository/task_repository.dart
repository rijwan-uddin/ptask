
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ptask/models/task_response.dart';

class TaskRepository {
  Future<List<dynamic>> fetchUserTasks(String id, String token) async {
    final url = Uri.parse('https://protask.shadhintech.com/api/user/$id/task');

    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          "token": token,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var taskRes = taskResponseFromJson(jsonEncode(data));

        return taskRes.tasks ?? [];
      } else {
        throw Exception("Failed to fetch tasks: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error fetching tasks: $e");
    }
  }
}
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:ptask/models/task_response.dart';
//
// class TaskRepository {
//   Future<void> fetchUserTasks(String id, String token) async {
//     final url = Uri.parse('https://protask.shadhintech.com/api/user/$id/task');
//
//     print('API URL: $url');
//     print('API token: $token');
//     try {
//       final response = await http.post(
//         url,
//         body: jsonEncode({
//           "token": token,
//         }),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       // Log the response details
//       print('Response Status: ${response.statusCode}');
//       print('Response Body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//
//         var taskRes = taskResponseFromJson(jsonEncode(data));
//         print('tasks:${taskRes.tasks![0].project!.title}');
//         print('tasks:${taskRes.tasks![0].title}');
//         print('tasks:${taskRes.tasks![0].description}');
//         print('tasks:${taskRes.tasks![0].list!.title}');
//         print('tasks:${taskRes.tasks![0].createdAt}');
//         print('tasks:${taskRes.tasks![0].dueDate}');
//
//         var taskList = taskRes.tasks;
//       } else {
//         throw Exception("Failed to fetch tasks: ${response.body}");
//       }
//     } catch (e) {
//       print('my task error $e');
//     }
//   }
// }