import 'package:get/get.dart';
import 'package:tm_getx/data/services/network_caller.dart';
import 'package:tm_getx/data/utils/urls.dart';

import '../../data/models/network_response.dart';

class ForgotOtpController extends GetxController{

  bool _inProgress=false;
  bool isSucess=false;
  String? _errorMessage;

  String? get errorMessage=>_errorMessage;
  bool get inProgress=>_inProgress;

  Future<bool> recoverOTPVerify(String code,String email) async {
      _inProgress = true;
      update();


    String _code = code;
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoverOTPVerify(email, _code),
    );



    if (response.isSuccess) {

      isSucess=true;
    } else {
     _errorMessage=response.errorMessage;
    }
    _inProgress=false;
    update();
    return isSucess;
  }

}
