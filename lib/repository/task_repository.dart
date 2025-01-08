// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:ptask/models/task_response.dart';
// import 'package:ptask/utils/app_constant.dart';
//
// class TaskRepository {
//   Future<List<Task>> fetchUserTasks(String id, String token) async {
//     final url = Uri.parse('${AppConstant.baseUrl}/user/$id/task');
//     List<Task> taskList = [];
//     try {
//       // final token = prefs.getString('auth_token'); token
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
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         var taskRes = taskResponseFromJson(jsonEncode(data));
//         // print('tasks:${taskRes.tasks![0].project!.title}');
//         // print('tasks:${taskRes.tasks![0].title}');
//         // print('tasks:${taskRes.tasks![0].description}');
//         // print('tasks:${taskRes.tasks![0].list!.title}');
//         // print('tasks:${taskRes.tasks![0].createdAt}');
//         // print('tasks:${taskRes.tasks![0].dueDate}');
//         print("tasks: ${response.body}");
//         taskList =  taskRes.tasks ?? [];
//       }
//       else {
//         throw Exception("Failed to fetch tasks: ${response.body}");
//       }
//     } catch (e) {
//       throw Exception("Error fetching tasks: $e");
//     }
//     return taskList ;
//   }
// }
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
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ptask/models/task_response.dart';
import 'package:ptask/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:ptask/view/login/login_screen.dart';

class TaskRepository {
  Future<List<Task>> fetchUserTasks(String id,  BuildContext context) async {
    final url = Uri.parse('${AppConstant.baseUrl}/user/$id/task');
    List<Task> taskList = [];
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('auth_token')?? '';
    // token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3Byb3Rhc2suc2hhZGhpbnRlY2guY29tL2FwaS9zaWduaW4iLCJpYXQiOjE3MzYwNzkxNjUsImV4cCI6MTczNjA4Mjc2NSwibmJmIjoxNzM2MDc5MTY1LCJqdGkiOiJCbW1WRHhKeFFiaTdtbVc2Iiwic3ViIjoiNTciLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3IiwiaWQiOjU3LCJyb2xlIjp7ImlkIjoyLCJuYW1lIjoiTm9ybWFsIiwic2x1ZyI6Im5vcm1hbCIsImNyZWF0ZV93b3Jrc3BhY2UiOjAsImNyZWF0ZV9wcm9qZWN0IjowLCJhY2Nlc3MiOm51bGwsImNyZWF0ZWRfYXQiOm51bGwsInVwZGF0ZWRfYXQiOm51bGx9fQ.8c-DOeF9HPQ9shby3bO95AAZrA1D6d7LjZDENNh5f9c';
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
        taskList = taskRes.tasks ?? [];
      } else if (response.statusCode == 401) {
        // Handle Unauthorized - logout the user automatically
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        // Navigate to login screen and remove all previous routes from the stack
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false,
        );
        throw Exception("Unauthorized access - Logging out");
      } else {
        throw Exception("Failed to fetch tasks: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error fetching tasks: $e");
    }
    return taskList;
  }
}
