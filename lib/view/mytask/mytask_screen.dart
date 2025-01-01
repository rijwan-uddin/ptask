import 'package:flutter/material.dart';
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

class _MyTasksScreenState extends State<MyTasksScreen> implements TaskViewInterface {
  late TaskPresenter presenter;
  List<dynamic> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    presenter = TaskPresenter(TaskRepository(), this);
    presenter.fetchUserTasks(widget.userId, widget.token);
  }

  @override
  void onFetchTasksSuccess(List<dynamic> fetchedTasks) {
    setState(() {
      tasks = fetchedTasks;
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
        title: Text('My Tasks'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : tasks.isEmpty
          ? Center(child: Text('No tasks found'))
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
class CustomWidgets {
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
  }}
// import 'package:flutter/material.dart';
// import '../../utils/toast_utils.dart';
// import '../../repository/task_repository.dart';
//
// class MyTasksScreen extends StatefulWidget {
//   final String userId;
//   final String token;
//
//   const MyTasksScreen({
//     Key? key,
//     required this.userId,
//     required this.token,
//   }) : super(key: key);
//
//   @override
//   _MyTasksScreenState createState() => _MyTasksScreenState();
// }
//
// class _MyTasksScreenState extends State<MyTasksScreen> {
//   late TaskRepository repository;
//   List<dynamic> tasks = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     repository = TaskRepository();
//     fetchTasks();
//   }
//
//   Future<void> fetchTasks() async {
//     try {
//       final fetchedTasks = await repository.fetchUserTasks(widget.userId, widget.token);
//       setState(() {
//         tasks = fetchedTasks;
//         isLoading = false;
//       });
//     } catch (error) {
//       setState(() {
//         isLoading = false;
//       });
//       ToastUtils.showToast(error.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Tasks'),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : tasks.isEmpty
//           ? const Center(child: Text('No tasks found'))
//           : ListView.builder(
//         itemCount: tasks.length,
//         itemBuilder: (context, index) {
//           final task = tasks[index];
//           return TaskCard(task: task);
//         },
//       ),
//     );
//   }
// }
//
// class TaskCard extends StatelessWidget {
//   final Map<String, dynamic> task;
//
//   const TaskCard({Key? key, required this.task}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               task['title'] ?? 'Untitled Task',
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               task['description'] ?? 'No description available',
//               style: const TextStyle(fontSize: 14),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Due: ${task['due_date'] ?? 'No due date'}',
//               style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
