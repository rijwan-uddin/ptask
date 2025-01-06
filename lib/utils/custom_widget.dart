
import 'package:flutter/material.dart';
import 'package:ptask/models/task_response.dart';

class CustomLogo extends StatelessWidget {
  final double height;
  final double width;

  const CustomLogo({Key? key, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/protaskLogo.jpg',
        height: height,
        width: width,
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final Function(String)? onSubmitted;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: (value) {
        if (labelText == 'Email' && (value == null || !value.contains('@shadhinlab'))) {
          return 'Please enter a valid email address';
        }
        if (labelText == 'Password' && (value == null || value.length < 6)) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(label),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String text;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.isLoading,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(115, 102, 255, 1), // Button color
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
//
// class CustomWidgets {
//   static Widget taskCard( Task task) {
//     return Card(
//       margin: const EdgeInsets.all(8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Project: ${task.project!.title ?? 'No Project Title'}',
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             const SizedBox(height: 4),
//             Text('Task: ${task.title ?? 'No Title'}'),
//             const SizedBox(height: 4),
//             Text('Description: ${task.description ?? 'No Description'}'),
//             const SizedBox(height: 4),
//             Text('Status: ${task.list!.title ?? 'No List Title'}'),
//             const SizedBox(height: 4),
//             Text('Created At: ${task.createdAt ?? 'No Date'}'),
//             const SizedBox(height: 4),
//             Text('Due Date: ${task.dueDate ?? 'No Due Date'}'),
//             const SizedBox(height: 8),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.end,
//             //   // // children: [
//             //   // //   // Icon(
//             //   // //   //   task. == true ? Icons.check_circle : Icons.pending,
//             //   // //   //   color: task['completed'] == true ? Colors.green : Colors.orange,
//             //   // //   ),
//             //   // ],
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CustomWidgets {
  static Widget taskCard(Task task) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                task.project?.title ?? 'No Project Title',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              task.title ?? 'No Title',
              style: const TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 4),
                Text(
                  'Description: ${task.description ?? 'No Description'}',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Status: ${task.list?.title ?? 'No List Title'}',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Created At: ${task.createdAt ?? 'No Date'}',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Due date: ${task.dueDate ?? 'No Date'}',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//rijwan.uddin@shadhinlab.com
//12345678