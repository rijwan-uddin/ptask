import 'dart:convert';
import 'package:http/http.dart' as http;

class TaskRepository {
  final String baseUrl = 'https://protask.shadhintech.com/api';

  Future<List<dynamic>> fetchUserTasks(String userId, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/$userId/task'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token}),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      print('result :$result');

      if (result['success'] == true) {
        return result['data']; // Assuming "data" contains the list of tasks
      } else {
        throw Exception(result['message'] ?? 'Failed to fetch tasks');
      }
    } else {
      throw Exception('Failed to fetch tasks: ${response.body}');
    }
  }
}
