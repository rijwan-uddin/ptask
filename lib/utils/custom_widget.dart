
import 'package:flutter/material.dart';
import 'package:ptask/models/task_response.dart';
import 'package:intl/intl.dart';

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
//
// class CustomTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final String labelText;
//   final FocusNode? focusNode;
//   final TextInputType? keyboardType;
//   final TextInputAction? textInputAction;
//   final bool isPassword;
//   final String? errorText;
//   final void Function(String)? onSubmitted;
//
//   CustomTextField({
//     required this.controller,
//     required this.labelText,
//     this.focusNode,
//     this.keyboardType,
//     this.textInputAction,
//     this.isPassword = false,
//     this.errorText,
//     this.onSubmitted,
//   });
//
//   @override
//   _CustomTextFieldState createState() => _CustomTextFieldState();
// }
//
// class _CustomTextFieldState extends State<CustomTextField> {
//   bool isPasswordVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextFormField(
//           // validator:  //text form key onujai validator check korte hbe
//           controller: widget.controller,
//           focusNode: widget.focusNode,
//           keyboardType: widget.keyboardType,
//           textInputAction: widget.textInputAction,
//           obscureText: widget.isPassword && !isPasswordVisible,
//           onFieldSubmitted: widget.onSubmitted,
//           decoration: InputDecoration(
//             labelText: widget.labelText,
//             errorText: widget.errorText,
//             border: OutlineInputBorder(),
//             suffixIcon: widget.isPassword
//                 ? IconButton(
//               icon: Icon(
//                 isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//               ),
//               onPressed: () {
//                 setState(() {
//                   isPasswordVisible = !isPasswordVisible;
//                 });
//               },
//             )
//                 : null,
//           ),
//         ),
//
//       ],
//     );
//   }
// }

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isPassword;
  final String? errorText;
  final void Function(String)? onSubmitted;
  final String? Function(String?)? validator; // Added validator property

  CustomTextField({
    required this.controller,
    required this.labelText,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.isPassword = false,
    this.errorText,
    this.onSubmitted,
    this.validator, // Initialize validator
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: widget.isPassword && !isPasswordVisible,
          onFieldSubmitted: widget.onSubmitted,
          validator: widget.validator, // Use the validator property
          decoration: InputDecoration(
            labelText: widget.labelText,
            errorText: widget.errorText,
            border: OutlineInputBorder(),
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            )
                : null,
          ),
        ),
      ],
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



class CustomWidgets {
  static Widget taskCard(Task task) {
    // Helper function to strip HTML tags
    String removeHtmlTags(String? htmlString) {
      if (htmlString == null) return 'No Description';
      final RegExp htmlTagRegExp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
      return htmlString.replaceAll(htmlTagRegExp, '');
    }

    // Function to format the date
    String formatDate(DateTime? dateTime) {
      if (dateTime == null) return 'No Date';


      return DateFormat('MMM dd, yyyy h:mm a').format(dateTime);
    }

    String formatDateString(String? dateString) {
      if (dateString == null || dateString.isEmpty) return 'No Date';

      try {
        final DateTime dateTime = DateTime.parse(dateString);
        return DateFormat('MMM dd, yyyy h:mm a').format(dateTime);
      } catch (e) {
        return 'Invalid Date';
      }
    }

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                task.title ?? 'No Title',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Text(
                task.project?.title ?? 'No Project Title',
                style: const TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right, // Aligns to the right
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align all child widgets to the left
              children: [
                const SizedBox(height: 4),
                Text(
                  'Task: ${task.title ?? 'No Title'}',
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.left, // Ensure alignment to the left
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerLeft, // Ensure alignment for description
                  child: Text(
                    'Description: ${removeHtmlTags(task.description)}',
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.left, // Explicitly align text to the left
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Status: ${task.list?.title ?? 'No List Title'}',
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.left, // Ensure alignment to the left
                ),
                const SizedBox(height: 4),
                Text(
                  'Created At: ${formatDate(task.createdAt)}', // Use the formatDate function
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.left, // Ensure alignment to the left
                ),
                const SizedBox(height: 4),
                Text(
                  'Due Date: ${formatDate(task.dueDate)}', // Use the formatDate function
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.left, // Ensure alignment to the left
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
