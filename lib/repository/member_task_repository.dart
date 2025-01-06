// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// // import 'package:ptask/models/task_response.dart';
// //
// // class MemberTaskRepository {
// //   Future<List<User>> fetchMemberTasks(String token) async {
// //     final url = Uri.parse('https://protask.shadhintech.com/api/all/users');
// //     List<User> userList = [];
// //     try {
// //       print('Fetching member tasks...');
// //       print('API URL: $url');
// //       print('Token: $token');
// //
// //       final response = await http.get(
// //         url,
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $token',
// //         },
// //       );
// //
// //       print('Response Status Code: ${response.statusCode}');
// //       print('Response Body: ${response.body}');
// //
// //       if (response.statusCode == 200) {
// //         final users = jsonDecode(response.body) as List;
// //         userList = users.map((user) => User.fromJson(user)).toList();
// //         print('Fetched Data: $userList');
// //         return userList;
// //       } else {
// //         throw Exception("Failed to fetch member tasks: ${response.body}");
// //       }
// //     } catch (e) {
// //       print('Error: $e');
// //       throw Exception("Error fetching member tasks: $e");
// //     }
// //   }
// // }
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// void main() async {
//   final url = Uri.parse('https://protask.shadhintech.com/api/user/57/task');
//
//   final token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3Byb3Rhc2suc2hhZGhpbnRlY2guY29tL2FwaS9zaWduaW4iLCJpYXQiOjE3MzIwNjg2MzcsImV4cCI6MTczMjA3MjIzNywibmJmIjoxNzMyMDY4NjM3LCJqdGkiOiI2TXFKdzNwMXFFa0N2VmRjIiwic3ViIjoiMSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjciLCJpZCI6MSwicm9sZSI6eyJpZCI6MSwibmFtZSI6IkFkbWluIiwic2x1ZyI6ImFkbWluIiwiY3JlYXRlX3dvcmtzcGFjZSI6MSwiY3JlYXRlX3Byb2plY3QiOjEsImFjY2VzcyI6bnVsbCwiY3JlYXRlZF9hdCI6bnVsbCwidXBkYXRlZF9hdCI6bnVsbH19.xKJrgM4kmlfYg3wtZjlM39sR6wBkpcr82lPza5Y2Rp8";
//
//   try {
//     final response = await http.post(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({
//         'token': token, // If required by the API
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       // Successful request
//       final data = json.decode(response.body);
//       print('Response data: $data');
//     } else {
//       print('Error: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//   } catch (e) {
//     print('An error occurred: $e');
//   }
// }
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class MemberTaskRepository {
//   // Method to fetch all users
//   Future<void> fetchAllUsers(String token) async {
//     final url = Uri.parse('https://protask.shadhintech.com/api/all/users');
//
//     try {
//       final response = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print('All Users Response: $data');
//       } else {
//         print('Failed to fetch users. Status Code: ${response.statusCode}');
//         print('Response: ${response.body}');
//       }
//     } catch (e) {
//       print('Error fetching users: $e');
//     }
//   }
// }
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class MemberTaskRepository {
//   // Future<void> fetchAllUsers(String token) async {
//   //   final url = Uri.parse('https://protask.shadhintech.com/api/all/users');
//   //
//   //   try {
//   //     final response = await http.get(
//   //       url,
//   //       headers: {
//   //         'Content-Type': 'application/json',
//   //         'Authorization': 'Bearer $token',
//   //       },
//   //     );
//   //
//   //     if (response.statusCode == 200) {
//   //       final data = jsonDecode(response.body);
//   //
//   //     } else {
//   //       print('Failed to fetch users. Status Code: ${response.statusCode}');
//   //       print('Response: ${response.body}');
//   //
//   //     }
//   //   } catch (e) {
//   //     print('Error fetching users: $e');
//   //
//   //   }
//   // }
//   //
//
//   Future<void> fetchAllUsers(String token) async {
//     final url = Uri.parse('https://protask.shadhintech.com/api/all/users');
//
//     try {
//       print('Making request to $url');
//       print('Token: $token');
//
//       final response = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print('Success: $data');
//       } else {
//         print('Failed to fetch users. Status Code: ${response.statusCode}');
//         print('Response: ${response.body}');
//       }
//     } catch (e) {
//       print('Error fetching users: $e');
//     }
//   }
//
// }
//
import 'dart:convert';
import 'package:http/http.dart' as http;

class MemberTaskRepository {

  Future<void> fetchUserMembers(
      {required String token, required Map<String, String> payload}) async {
    final url = Uri.parse('https://protask.shadhintech.com/api/all/users')
        .replace(queryParameters: payload);

    try {
      final response = await http.get(
        url,

        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
print("user list: ${response.body}");


      } else {
        throw Exception("Failed to fetch tasks: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error fetching tasks: $e");
    }

  }

}

