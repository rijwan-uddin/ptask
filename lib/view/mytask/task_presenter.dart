
import '../../repository/task_repository.dart';
import 'task_interface.dart';

class TaskPresenter {
  final TaskRepository repository;
  final TaskViewInterface view;

  TaskPresenter(this.repository, this.view);

  void fetchUserTasks(String userId, String token) async {
    try {
      final tasks = await repository.fetchUserTasks(userId, token);
      view.onFetchTasksSuccess(tasks);
    } catch (e) {
      view.onFetchTasksError(e.toString());
    }
  }
}


