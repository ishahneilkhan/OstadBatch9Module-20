import 'package:get/get.dart';

import '../../data/models/login_model.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class SignInController extends GetxController{

  bool _inProgress=false;
  bool isSucess=false;
  String? _errorMessage;
  String? _logInMessage;
  String? get errorMessage=>_errorMessage;
  String? get logInMessage=>_logInMessage;


  bool get inProgress=>_inProgress;

  Future<bool> signIn(String email,String password) async {
    _inProgress = true;
    isSucess=false;
    update();

    Map<String, dynamic> requestBody = {
      'email' : email,
      'password' : password,
    };

    final NetworkResponse response =
    await NetworkCaller.postRequest(url: Urls.login, body: requestBody);

    if (response.isSuccess) {
      isSucess=true;
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!.first);


    }
      _errorMessage = response.errorMessage;

    _inProgress = false;
    update();
    return isSucess;
  }

}
