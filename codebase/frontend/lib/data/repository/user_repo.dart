import 'package:get/get_connect/connect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable_app/data/api/api_client.dart';
import 'package:timetable_app/utils/app_constants.dart';

class UserRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  UserRepo({required this.apiClient, required this.sharedPreferences});

  // get user
  Future<Response> getUser() async {
    int reference = sharedPreferences.getInt(AppConstants.userReference) ?? 9273217;
    return await apiClient.getData('${AppConstants.users}/$reference');
  }
}
