import 'dart:async';

import 'package:get/get.dart';
import 'package:timetable_app/data/models/responses/room_available_times.dart';
import 'package:timetable_app/data/models/responses/room_status_model.dart';
import 'package:timetable_app/data/repository/room_repo.dart';
import 'package:timetable_app/helpers/available_times.dart';
import 'package:timetable_app/helpers/extensions.dart';

import '../data/models/responses/room_model.dart';

class RoomController extends GetxController implements GetxService {
  final RoomRepo roomRepo;
  RoomController(this.roomRepo);

  // GET ALL ROOMS

  List<RoomModel>? _rooms;
  List<RoomModel>? get rooms => _rooms;

  Future<void> fetchAllRooms() async {
    Response response = await roomRepo.fetchAllRooms();
    if (response.statusCode == 200) {
      List<dynamic> body = response.body['rooms'];
      _rooms =
          List.generate(body.length, (index) => RoomModel.fromMap(body[index]));
    } else {}
    update();
  }

  int roomOpen = 800;
  int roomClose = 1800;

  // GET LIVE ROOMS
  List<RoomStatusModel>? _liveRooms;
  List<RoomStatusModel>? get liveRooms => _liveRooms;

  Future<void> fetchLiveRooms(Map<String, dynamic> query) async {
    Response response = await roomRepo.fetchLiveRooms(query);
    if (response.statusCode == 200) {
      _liveRooms = [];
      List<dynamic> body = response.body['rooms'];
      _liveRooms = List.generate(
        body.length,
        (index) => RoomStatusModel.fromMap(
          body[index],
        ),
      );
      _liveRooms!.sort((a, b) {
        return a.endTime.compareTo(b.endTime);
      });
    } else {}
    update();
  }

  // GET EMPTY ROOMS
  List<RoomStatusModel>? _emptyRooms;
  List<RoomStatusModel>? get emptyRooms => _emptyRooms;

  List<RoomStatusModel>? _availableToday;
  List<RoomStatusModel>? get availableToday => _availableToday;

  Future<void> fetchEmptyRooms(Map<String, dynamic> query) async {
    Response response = await roomRepo.fetchEmptyRooms(query);
    if (response.statusCode == 200) {
      _emptyRooms = [];
      List<dynamic> body = response.body['rooms'];
      _emptyRooms = List.generate(
        body.length,
        (index) => RoomStatusModel.fromMap(
          body[index],
        ),
      );
      List i =
          List.generate(_liveRooms!.length, (index) => _liveRooms![index].room);
      _emptyRooms!.removeWhere((element) {
        return i.contains(element.room) ||
            element.room.type == RoomType.other ||
            element.room.location == RoomLocation.other;
      });
      _emptyRooms!.sort((a, b) {
        return a.startTime.compareTo(b.startTime);
      });
    } else {}

    update();
  }

  List<TimeRange>? _availableTimes;
  List<TimeRange>? get availableTimes => _availableTimes;

  Future<void> getRoomAvailableTimes(Map<String, dynamic> query) async {
    _availableTimes = null;
    // update();
    Response response = await roomRepo.getRoomAvailableTimes(query);
    if (response.statusCode == 200) {
      List<dynamic> body = response.body['usage_times'];
      List<RoomAvailableTime> busyTimesA = List.generate(
        body.length,
        (index) => RoomAvailableTime.fromMap(body[index]),
      );
      List<List<String>> busyTimesB = List.generate(busyTimesA.length, (index) {
        RoomAvailableTime time = busyTimesA[index];
        return [time.startTime.toTime, time.endTime.toTime];
      });
      _availableTimes = timings(busyTimesB);
    } else {}
    update();
  }
}

// CRAZY FUNCTION TO RETURN AVAILABLE TIMES
List<TimeRange> timings(List<List<String>> busyTimes) {
  print(busyTimes);
  if (busyTimes.isEmpty) {
    return [TimeRange(Time(0, 0), Time(18, 0))];
  }
  TimeRange.timeRanges.clear();
  for (var i in busyTimes) {
    TimeRange.add(Time.fromString(i[0]), Time.fromString(i[1]));
  }
  TimeRange.sort();
  List<TimeRange> res = [];
  bool header = false;
  String roomOpen = "08:00";
  String roomClose = "18:00";
  List<TimeRange> ranges = TimeRange.timeRanges;
  for (int i = 0; i < ranges.length; i++) {
    TimeRange timeRange = ranges[i];
    Time roomOpenTime = Time.fromString(roomOpen);
    if (!header && timeRange.start != roomOpenTime) {
      res.add(TimeRange(roomOpenTime, timeRange.start));
    }
    if (i != ranges.length - 1) {
      Time timeDiff = ranges[i + 1].start.subtractTime(timeRange.end);
      if (timeDiff.h > 0 || timeDiff.m > 5) {
        Time endTime = ranges[i + 1].start.subtractTime(Time(0, 0));
        Time freeTimeStart = timeRange.end.addDuration(Time(0, 0));
        Time freeTimeEnd = Time(endTime.h, endTime.m);
        res.add(TimeRange(freeTimeStart, freeTimeEnd));
      }
    } else {
      if (timeRange.end != Time.fromString(roomClose)) {
        res.add(
          TimeRange(
            timeRange.end.addDuration(Time(0, 0)),
            Time.fromString(roomClose),
          ),
        );
      }
    }
    header = true;
  }
  res.removeWhere((element) {
    return element.end.subtractTime(element.start) < Time(0, 30);
  });
  return res;
}
