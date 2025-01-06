// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class MemberTaskRepository {
//   Future<void> fetchUserMembers(
//       {required String token, required Map<String, String> payload}) async {
//     final url = Uri.parse('https://protask.shadhintech.com/api/all/users')
//         .replace(queryParameters: payload);
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
//         print("user list: ${response.body}");
//       } else {
//         throw Exception("Failed to fetch tasks: ${response.body}");
//       }
//     } catch (e) {
//       throw Exception("Error fetching tasks: $e");
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ptask/models/userList.dart';

class MemberTaskRepository {
  Future<List<UserList>> fetchUserMembers({required String token, required Map<String, String> payload}) async {
    final url = Uri.parse('https://protask.shadhintech.com/api/all/users')
        .replace(queryParameters: payload);

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',  // Pass the token here
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<UserList> userList = (data as List).map((userData) => UserList.fromJson(userData)).toList();
        print("uusers: ${response.body}");
        ///api theke data astese correctly

        return userList;  // Return the list of UserList
      } else {
        throw Exception("Failed to fetch : ${response.body}");
      }
    } catch (e) {
      throw Exception("Error fetching : $e");
    }
  }
}
