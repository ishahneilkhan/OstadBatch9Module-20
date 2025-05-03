import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tm_getx/data/models/user_model.dart';
import 'package:tm_getx/data/utils/urls.dart';
import 'package:tm_getx/ui/controllers/auth_controller.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';

class ProfileController extends GetxController {
  bool _inProgress = false;
  bool _isSucess = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  bool get isSucess => _isSucess;
  String? get errorMessage => _errorMessage;

  XFile? _selectedImage;
  XFile? get selectedImage => _selectedImage;

  Future<void> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _selectedImage = pickedImage;
      update();
    }
  }
  String getSelectedPhotoTitle() {
    if (_selectedImage != null) {
      return _selectedImage!.name;
    }
    return 'Select Photo';
  }


  Future<bool> updateProfile(String email, String pass, String firstname, String lastname, String phone) async {
    try {
      _inProgress = true;
      _isSucess = false;
      _errorMessage = null; // Clear any previous error messages
      update();

      Map<String, dynamic> requestBody = {
        "email": email,
        "firstName": firstname,
        "lastName": lastname,
        "mobile": phone,
      };

      if (pass.isNotEmpty) {
        requestBody['password'] = pass;
      }

      if (_selectedImage != null) {
        List<int> imageBytes = await _selectedImage!.readAsBytes();
        String convertedImage = base64Encode(imageBytes);
        requestBody['photo'] = convertedImage;
      }

      final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.updateProfile,
        body: requestBody,
      );

      if (response.isSuccess) {
        _isSucess = true;
        UserModel userModel = UserModel.fromJson(requestBody);
        AuthController.saveUserData(userModel);
      } else {
        _isSucess = false;
        _errorMessage = response.errorMessage ?? 'An unknown error occurred. Please try again later.';
        print('Error Message: $_errorMessage');
      }
    } catch (error) {
      _isSucess = false;
      _errorMessage = 'An error occurred: ${error.toString()}';
      print('Catch Error: $_errorMessage');
    } finally {
      _inProgress = false;
      update();
    }

    return _isSucess;
  }




}
