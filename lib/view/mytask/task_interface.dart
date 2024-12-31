abstract class TaskViewInterface {
  void onFetchTasksSuccess(List<dynamic> tasks);
  void onFetchTasksError(String error);
}
