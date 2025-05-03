import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';


class ResetPasswordController extends GetxController{

  bool _inProgress=false;
  bool _isSucess=false;
  String? _errorMessage;
  String? _ResetMessage;

  String? get errorMessage=>_errorMessage;
  bool get inProgress=>_inProgress;
  String? get ResetMessage=>_ResetMessage;


  Future<bool> resetPassword(String email,String otp,String pass) async {
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      'email' : email,
      'OTP' : otp,
      'password' : pass,
    };

    final NetworkResponse response =
    await NetworkCaller.postRequest(url: Urls.resetPassword(), body: requestBody);

    if (response.isSuccess) {
      _isSucess=true;
    } else {
     _errorMessage=response.errorMessage;
    }
    _inProgress = false;
    update();

    return _isSucess;
  }

}
