
import '../../repository/task_repository.dart';
import 'task_interface.dart';

class TaskPresenter {
  final TaskRepository repository;
  final TaskViewInterface view;

  TaskPresenter(this.repository, this.view);

  void fetchUserTasks(String userId,  context) async {
    try {
      final tasks = await repository.fetchUserTasks(userId, context);
      view.onFetchTasksSuccess(tasks);
    } catch (e) {
      view.onFetchTasksError(e.toString());
    }
  }
}


