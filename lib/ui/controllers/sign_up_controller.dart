import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class SignUpController extends GetxController{
  bool _inProgress=false;
  String? _errorMessage;
  bool _isSucess=false;

  bool get inProgress=>_inProgress;
  String? get errorMessage=> _errorMessage;
  bool get isSucess=>_isSucess;

  Future<bool> signUp(String email,String firstname,String lastname,String mobile,String password) async {
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstname,
      "lastName": lastname,
      "mobile": mobile,
      "password": password,
      "photo":""
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.registration,
      body: requestBody,
    );


    if (response.isSuccess) {
      _isSucess=true;
    } else {
      _errorMessage=response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSucess;
  }
}
