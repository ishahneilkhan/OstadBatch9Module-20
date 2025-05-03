import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';



class ProgressTaskController extends GetxController {

  List<TaskModel>_taskList=[];

  bool _inProgress=false;
  bool isSucess=false;
  String? _errorMessage;

  List<TaskModel>get taskList=>_taskList;
  String? get errorMessage=>_errorMessage;
  bool get inProgress=>_inProgress;

  Future<bool>inProgressTaskList()async{

    _inProgress=true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.progressTaskList,
    );

    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _taskList = taskListModel.taskList ?? [];
      isSucess=true;
    } else {
      _errorMessage=response.errorMessage;
    }
    _inProgress=false;
    update();

    return isSucess;
  }

}
