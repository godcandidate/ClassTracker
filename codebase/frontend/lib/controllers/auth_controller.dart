import 'package:get/get.dart';
import 'package:timetable_app/controllers/user_controller.dart';
import 'package:timetable_app/data/models/body/login_body.dart';
import 'package:timetable_app/data/models/responses/response_model.dart';
import 'package:timetable_app/data/repository/auth_repo.dart';

import '../data/models/responses/user_model.dart';
import '../views/base/custom_snackbar.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController(this.authRepo);

  bool _isLogging = false;
  bool get isLogging => _isLogging;

  bool loggedIn() {
    return authRepo.loggedIn();
  }

  // Logout
  Future<void> logout() async {
    Get.find<UserController>().setUser(null);
    await authRepo.logout();
  }

  // Login
  Future<ResponseModel> login(LoginBody body) async {
    _isLogging = true;
    update();
    ResponseModel responseModel;
    Response response = await authRepo.login(body);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, 'Authenticated');
      Get.find<UserController>()
          .setUser(UserModel.fromMap(response.body['user']));
      await authRepo.updateToken(true, response.body['user']['reference']);
    } else {
      String error;
      if (response.body == null) {
        error = "An error occured";
        showCustomSnackBar(response.statusText!, isError: true);
      } else {
        error = response.body['error'];
      }
      responseModel = ResponseModel(false, error);
    }
    _isLogging = false;
    update();
    return responseModel;
  }
}
