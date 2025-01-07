
import 'package:flutter/material.dart';
import 'package:ptask/models/task_response.dart';
import '../../utils/custom_widget.dart';
import '../../utils/toast_utils.dart';
import '../../repository/task_repository.dart';
import 'task_presenter.dart';
import 'task_interface.dart';
class MyTasksScreen extends StatefulWidget {
  final String userId;
  final String token;

  const MyTasksScreen({
    Key? key,
    required this.userId,
    required this.token,
  }) : super(key: key);

  @override
  _MyTasksScreenState createState() => _MyTasksScreenState();
}
//
// class _MyTasksScreenState extends State<MyTasksScreen> implements TaskViewInterface {
//   late TaskPresenter presenter;
//   List<Task> tasks = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     presenter = TaskPresenter(TaskRepository(), this);
//     presenter.fetchUserTasks(widget.userId, widget.token);
//   }
//
//   @override
//   void onFetchTasksSuccess(List<Task> fetchedTasks) {
//     setState(() {
//       tasks = fetchedTasks;
//       isLoading = false;
//     });
//   }
//
//   @override
//   void onFetchTasksError(String error) {
//     setState(() {
//       isLoading = false;
//     });
//     ToastUtils.showToast(error);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tasks'),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : tasks.isEmpty
//           ? const Center(child: Text('No tasks found'))
//           : ListView.builder(
//         itemCount: tasks.length,
//         itemBuilder: (context, index) {
//           final task = tasks[index];
//           return CustomWidgets.taskCard(task); // Pass individual task here
//         },
//       ),
//     );
//   }
// }
class _MyTasksScreenState extends State<MyTasksScreen> implements TaskViewInterface {
  late TaskPresenter presenter;
  List<Task> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    presenter = TaskPresenter(TaskRepository(), this);
    presenter.fetchUserTasks(widget.userId, widget.token);
  }

  @override
  void onFetchTasksSuccess(List<Task> fetchedTasks) {
    setState(() {
      // Filter tasks to include only those with the list title 'In Progress'
      tasks = fetchedTasks.where((task) => task.list?.title == 'In Progress').toList();
      isLoading = false;
    });
  }

  @override
  void onFetchTasksError(String error) {
    setState(() {
      isLoading = false;
    });
    ToastUtils.showToast(error);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : tasks.isEmpty
          ? const Center(child: Text('No tasks in progress'))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return CustomWidgets.taskCard(task); // Pass individual task here
        },
      ),
    );
  }
}


