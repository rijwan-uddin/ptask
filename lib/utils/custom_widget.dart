import 'package:flutter/material.dart';

class CustomWidgets {
  static Widget customTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
      obscureText: obscureText,
    );
  }

  static Widget customButton({
    required String text,
    required VoidCallback? onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }




  static Widget taskCard(Map<String, dynamic> task) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(task['title'] ?? 'No Title'),
        subtitle: Text(task['description'] ?? 'No Description'),
        trailing: Icon(
          task['completed'] ? Icons.check_circle : Icons.pending,
          color: task['completed'] ? Colors.green : Colors.orange,
        ),
      ),
    );
  }
}


