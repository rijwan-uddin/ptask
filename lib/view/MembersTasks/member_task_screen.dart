// import 'package:flutter/material.dart';
// import 'package:ptask/models/task_response.dart';
// import 'package:ptask/repository/member_task_repository.dart';
// import 'member_task_presenter.dart';
//
//
// class MemberTaskScreen extends StatefulWidget {
//   final String token;
//
//   const MemberTaskScreen({required this.token});
//
//   @override
//   _MemberTaskScreenState createState() => _MemberTaskScreenState();
// }
//
// class _MemberTaskScreenState extends State<MemberTaskScreen> {
//   late MemberTaskPresenter _presenter;
//   late Future<List<Task>> _memberTasks;
//
//   @override
//   void initState() {
//     super.initState();
//     _presenter = MemberTaskPresenter(MemberTaskRepository());
//     _memberTasks = _presenter.getMemberTasks(widget.token) as Future<List<Task>>;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Member Tasks'),
//       ),
//       body: FutureBuilder<List<Task>>(
//         future: _memberTasks,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No tasks found.'));
//           }
//
//           final tasks = snapshot.data!;
//           return ListView.builder(
//             itemCount: tasks.length,
//             itemBuilder: (context, index) {
//               final task = tasks[index];
//               return CustomWidgets.taskCard(task);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
// class CustomWidgets {
//   static Widget taskCard(Task task) {
//     return Card(
//       margin: const EdgeInsets.all(8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Member: ${ User ?? 'No Member Name'}',
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//                 color: Colors.blue,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Project: ${task.project?.title ?? 'No Project Title'}',
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             const SizedBox(height: 4),
//             Text('Task: ${task.title ?? 'No Title'}'),
//             const SizedBox(height: 4),
//             Text('Description: ${task.description ?? 'No Description'}'),
//             const SizedBox(height: 4),
//             Text('Status: ${task.list?.title ?? 'No List Title'}'),
//             const SizedBox(height: 4),
//             Text('Created At: ${task.createdAt ?? 'No Date'}'),
//             const SizedBox(height: 4),
//             Text('Due Date: ${task.dueDate ?? 'No Due Date'}'),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MemberTaskScreen extends StatelessWidget {
  final String token;

  const MemberTaskScreen({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
      ),
      body: Center(
        child: Text(
          'Members ',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

