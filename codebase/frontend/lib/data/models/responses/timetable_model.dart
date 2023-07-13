import 'dart:convert';

import 'package:timetable_app/data/models/responses/course_model.dart';
import 'package:timetable_app/data/models/responses/room_model.dart';

class TimetableModel {
  final CourseModel course;
  final int startTime;
  final int endTime;
  final String day;
  final RoomModel room;
  final bool recursive;
  bool _ongoing = false;

  TimetableModel({
    required this.course,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.room,
    required this.recursive,
  });

  Map<String, dynamic> toMap() {
    return {
      'course': course.toMap(),
      'startTime': startTime,
      'endTime': endTime,
      'day': day,
      'room': room.toMap(),
      'recursive': recursive,
    };
  }

  bool get onGoing => _ongoing;
  set ongoing(value) => _ongoing = value;

  factory TimetableModel.fromMap(Map<String, dynamic> map) {
    return TimetableModel(
      course: CourseModel.fromMap(map['course_details']),
      startTime: map['start_time'],
      endTime: map['end_time'],
      day: map['day'],
      room: RoomModel.fromMap(map['room']),
      recursive: map['recursive'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TimetableModel.fromJson(String source) =>
      TimetableModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TimetableModel(course: $course, startTime: $startTime, endTime: $endTime, day: $day, room: $room, ongoing: $_ongoing)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TimetableModel &&
        o.course == course &&
        o.startTime == startTime &&
        o.endTime == endTime &&
        o.day == day &&
        o.room == room;
  }

  @override
  int get hashCode {
    return course.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        day.hashCode ^
        room.hashCode;
  }
}
