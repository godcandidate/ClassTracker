import 'package:get/get_connect/connect.dart';
import 'package:timetable_app/data/api/api_client.dart';
import 'package:timetable_app/data/models/body/booking_body.dart';
import 'package:timetable_app/utils/app_constants.dart';

class ScheduleRepo {
  final ApiClient apiClient;
  const ScheduleRepo({required this.apiClient});


  Future<Response> createSchedule(BookingBody body) async{
    return await apiClient.postData(AppConstants.schedules, body.toMap());
  }
}
