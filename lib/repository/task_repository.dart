// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class TaskRepository {
//   final String baseUrl = 'https://protask.shadhintech.com/api';
//
//   Future<List<dynamic>> fetchUserTasks(String id, String token) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/user/$id/task'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'token': token}),
//     );
//     print(response.body);
//     if (response.statusCode == 200) {
//       final result = json.decode(response.body);
//
//       print('result :$result');
//       return result['data'] ['user'];
//
//     } else {
//       throw Exception('Failed to fetch tasks: ${response.body}');
//     }
//   }
// }
//


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ptask/models/task_response.dart';

class TaskRepository {
  Future<void> fetchUserTasks(String id, String token) async {


    final url = Uri.parse('https://protask.shadhintech.com/api/user/$id/task');

    print('API URL: $url');
    print('API token: $token');
try{
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

  // Log the response details
  print('Response Status: ${response.statusCode}');
  print('Response Body: ${response.body}');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    var taskRes = taskResponseFromJson(jsonEncode(data));
    print('tasks:${taskRes.tasks![0].project!.title}');
     var taskList = taskRes.tasks;
  } else {
    throw Exception("Failed to fetch tasks: ${response.body}");
  }
}
catch(e){
  print('my task error $e');

}

  }
}


// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class TaskRepository {
//   Future<List<dynamic>> fetchUserTasks(String userId, String token) async {
//     final url = Uri.parse('https://protask.shadhintech.com/api/user/$userId/task');
//     final response = await http.get(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data['tasks']; // Adjust based on actual API response structure.
//     } else {
//       throw Exception('Failed to fetch tasks: ${response.body}');
//     }
//   }
// }
