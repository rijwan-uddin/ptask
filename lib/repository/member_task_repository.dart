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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ptask/models/userList.dart';
import 'package:ptask/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/login/login_screen.dart';

class MemberTaskRepository {

  Future<List<UserList>> fetchUserMembers({required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final url = Uri.parse('${AppConstant.baseUrl}/all/users')
        .replace(queryParameters:   {'token': token},);

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
      }
      else {
        throw Exception("Failed to fetch : ${response.body}");
      }
    } catch (e) {
      throw Exception("Error fetching : $e");
    }
  }
}
