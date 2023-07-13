import 'package:get/get_connect/connect.dart';
import 'package:timetable_app/data/api/api_client.dart';
import 'package:timetable_app/utils/app_constants.dart';

class CourseRepo {
  final ApiClient apiClient;
  CourseRepo({required this.apiClient});

  Future<Response> getCourses(Map<String, dynamic> query) async {
    return await apiClient.getData(AppConstants.courses, query: query);
  }
}
