// import 'package:flutter/material.dart';
// import 'package:ptask/models/task_response.dart';
// import '../../utils/custom_widget.dart';
// import '../../utils/toast_utils.dart';
// import '../../repository/task_repository.dart';
// import 'task_presenter.dart';
// import 'task_interface.dart';
//
// class MyTasksScreen extends StatefulWidget {
//   final String userId;
//
//
//   const MyTasksScreen({
//     Key? key,
//     required this.userId,
//
//   }) : super(key: key);
//
//   @override
//   _MyTasksScreenState createState() => _MyTasksScreenState();
// }
//
//
//
// class _MyTasksScreenState extends State<MyTasksScreen>
//     implements TaskViewInterface {
//   late TaskPresenter presenter;
//   List<Task> tasks = [];
//   bool isLoading = true;
//   String userName = ''; // To store the user's name
//
//   @override
//   void initState() {
//     super.initState();
//     presenter = TaskPresenter(TaskRepository(), this);
//     presenter.fetchUserTasks(widget.userId, context);
//   }
//
//   @override
//   void onFetchTasksSuccess(List<Task> fetchedTasks) {
//     setState(() {
//       // Filter tasks to include only those with the list title 'In Progress'
//       tasks = fetchedTasks.where((task) => task.list?.title == 'In Progress')
//           .toList();
//
//       // Sort tasks by createdAt in descending order (recent tasks first)
//       tasks.sort((a, b) {
//         if (a.createdAt == null && b.createdAt == null)
//           return 0; // Both dates are null
//         if (a.createdAt == null) return 1; // Place null dates at the end
//         if (b.createdAt == null) return -1; // Place null dates at the end
//
//         return b.createdAt!.compareTo(a.createdAt!); // Descending order
//       });
//
//       // Update the user's name based on the tasks
//       if (tasks.isNotEmpty && tasks.first.assignees?.isNotEmpty == true) {
//         userName = tasks.first.assignees!.first.user?.name ?? 'Unknown User';
//       } else {
//         userName = 'No Assignee';
//       }
//
//       isLoading = false;
//     });
//   }
//
//   @override
//   void onFetchTasksError(String error) {
//     setState(() {
//       isLoading = false;
//     });
//     if (error.contains("Unauthorized access - Logging out")) {
//       return;
//     }
//     ToastUtils.showToast (error);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(userName.isNotEmpty ? '$userName\'s Tasks' : ''),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : tasks.isEmpty
//           ? const Center(child: Text('No tasks in progress'))
//           : ListView.builder(
//         itemCount: tasks.length,
//         itemBuilder: (context, index) {
//           final task = tasks[index];
//           return CustomWidgets.taskCard(task);
//         },
//       ),
//     );
//   }
// }///
///last
import 'package:flutter/material.dart';
import '../../utils/custom_widget.dart';
import '../../utils/toast_utils.dart';
import '../../repository/task_repository.dart';
import 'task_presenter.dart';
import 'task_interface.dart';
import 'package:ptask/models/task_response.dart';

class MyTasksScreen extends StatefulWidget {
  final String userId;
  final String userName;  // Added to hold the user's name

  const MyTasksScreen({
    Key? key,
    required this.userId,
    required this.userName,  // Receive userName as a parameter
  }) : super(key: key);

  @override
  _MyTasksScreenState createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> implements TaskViewInterface {
  late TaskPresenter presenter;
  List<Task> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    presenter = TaskPresenter(TaskRepository(), this);
    presenter.fetchUserTasks(widget.userId, context);
  }

  @override
  void onFetchTasksSuccess(List<Task> fetchedTasks) {
    setState(() {
      tasks = fetchedTasks.where((task) => task.list?.title == 'In Progress').toList();
      tasks.sort((a, b) {
        if (a.createdAt == null && b.createdAt == null) return 0;
        if (a.createdAt == null) return 1;
        if (b.createdAt == null) return -1;
        return b.createdAt!.compareTo(a.createdAt!);
      });
      isLoading = false;
    });
  }

  @override
  void onFetchTasksError(String error) {
    setState(() {
      isLoading = false;
    });
    if (error.contains("Unauthorized access - Logging out")) {
      return;
    }
    ToastUtils.showToast(error);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userName.isNotEmpty ? '${widget.userName}\'s Tasks' : 'My Tasks', // Display user name if available
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : tasks.isEmpty
          ? const Center(child: Text('No tasks in progress'))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return CustomWidgets.taskCard(task);
        },
      ),
    );
  }
}
