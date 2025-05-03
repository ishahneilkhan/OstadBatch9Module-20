import 'package:get/get.dart';
import 'package:tm_getx/data/models/network_response.dart';
import 'package:tm_getx/data/models/task_list_model.dart';
import 'package:tm_getx/data/models/task_model.dart';
import 'package:tm_getx/data/services/network_caller.dart';
import 'package:tm_getx/data/utils/urls.dart';

class CompleteTaskController extends GetxController{
  bool _inProgress=false;
  bool isSucess=false;
  String? _errorMessage;
  List<TaskModel> _taskList = [];

  List<TaskModel>get taskList=>_taskList;
  String? get errorMessage=>_errorMessage;
  bool get inProgress=>_inProgress;

  Future<bool> getCompletedTaskList() async {
    _inProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.completedTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responseData);
      _taskList = taskListModel.taskList ?? [];
      isSucess=true;
    } else {
      _errorMessage=response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSucess;
  }
}
