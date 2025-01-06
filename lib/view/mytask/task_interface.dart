import 'package:ptask/models/task_response.dart';

abstract class TaskViewInterface {
  void onFetchTasksSuccess(List<Task> tasks);
  void onFetchTasksError(String error);
}
