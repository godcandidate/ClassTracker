import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable_app/data/api/api_client.dart';
import 'package:timetable_app/utils/app_constants.dart';

class TimetableRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  TimetableRepo({required this.apiClient, required this.sharedPreferences});



  // FETCH USER'S TIMETABLE
  Future<Response> getTimetable(Map<String, dynamic> query) async{
     return await apiClient.getData(AppConstants.timetable, query: query);
  }
}
