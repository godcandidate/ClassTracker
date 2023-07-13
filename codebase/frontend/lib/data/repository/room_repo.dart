import 'package:get/get_connect/http/src/response/response.dart';
import 'package:timetable_app/data/api/api_client.dart';
import 'package:timetable_app/utils/app_constants.dart';

class RoomRepo {
  final ApiClient apiClient;
  RoomRepo({required this.apiClient});

  // FETCH ALL ROOMS
  Future<Response> fetchAllRooms() async {
    return await apiClient.getData(AppConstants.rooms);
  }

  // LIVE ROOMS
  Future<Response> fetchLiveRooms(Map<String, dynamic> query) async {
    return await apiClient.getData(AppConstants.rooms + AppConstants.liveRooms,
        query: query);
  }

  // EMPTY ROOMS
  Future<Response> fetchEmptyRooms(Map<String, dynamic> query) async {
    return await apiClient
        .getData(AppConstants.rooms + AppConstants.vacantRooms, query: query);
  }

  // ROOM'S AVAILABLE TIMINGS
  Future<Response> getRoomAvailableTimes(Map<String, dynamic> query) async {
    return await apiClient.getData(
        AppConstants.rooms + AppConstants.availableTimes,
        query: query);
  }
}
