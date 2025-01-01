// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class LoginRepository {
//   final String baseUrl = 'https://protask.shadhintech.com/api';
//
//   Future<Map<String, dynamic>> signIn(String email, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/signin'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     );
//
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to sign in: ${response.body}');
//     }
//   }
// }
