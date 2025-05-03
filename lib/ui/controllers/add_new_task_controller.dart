import 'package:get/get.dart';
import 'package:tm_getx/data/models/network_response.dart';
import 'package:tm_getx/data/services/network_caller.dart';
import 'package:tm_getx/data/utils/urls.dart';


class AddNewTaskController extends GetxController {
  bool _inProgress = false;
  bool _isSuccess = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  bool get isSuccess => _isSuccess;
  String? get errorMessage => _errorMessage;

  Future<bool> addNewTask(String title, String description) async {
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      'title': title,
      'description': description,
      'status': 'New',
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.addNewTask, body: requestBody);

    _inProgress = false;

    if (response.isSuccess) {
      _isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    update();
    return _isSuccess;
  }
}
