import 'package:get/get.dart';
import 'package:timetable_app/data/models/responses/response_model.dart';
import 'package:timetable_app/data/models/responses/user_model.dart';
import 'package:timetable_app/data/repository/user_repo.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController(this.userRepo);

  bool _fetchingUser = false;
  bool get fetchingUser => _fetchingUser;

  UserModel? _user;
  UserModel? get user => _user;

  // FETCH USER
  Future<ResponseModel> getUserInfo({bool reload = true}) async {
    if (reload) {
      _fetchingUser = true;
      update();
    }
    ResponseModel responseModel;
    Response response = await userRepo.getUser();
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "");
      _user = UserModel.fromMap(response.body['user']);
    } else {
      responseModel = ResponseModel(false, response.body ?? 'error');
    }
    _fetchingUser = false;
    update();
    return responseModel;
  }

  void setUser(dynamic user) {
    _user = user;
    update();
  }
}
