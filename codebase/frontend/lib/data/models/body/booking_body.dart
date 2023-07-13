import 'dart:convert';

import 'package:get/get.dart';
import 'package:timetable_app/controllers/user_controller.dart';
import 'package:timetable_app/data/models/responses/user_model.dart';

class BookingBody {
  final String room;
  final int year;
  final String day;
  final int startTime;
  final int endTime;
  final int reference;
  final String courseCode;
  BookingBody({
    required this.room,
    required this.year,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.reference,
    required this.courseCode,
  });

  Map<String, dynamic> toMap() {
    UserModel user = Get.find<UserController>().user!;
    return {
      'room': room,
      'year': year,
      'day': day,
      'start_time': startTime,
      'end_time': endTime,
      'booked_by': reference,
      'course_code': courseCode,
      'reference': reference,
      'programme': user.programme,
      'status': true,
    };
  }

  factory BookingBody.fromMap(Map<String, dynamic> map) {
    return BookingBody(
      room: map['room'],
      year: map['year'],
      day: map['day'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      reference: map['booked_by'],
      courseCode: map['course_code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingBody.fromJson(String source) =>
      BookingBody.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookingBody(room: $room, year: $year, day: $day, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BookingBody &&
        o.room == room &&
        o.year == year &&
        o.day == day &&
        o.startTime == startTime &&
        o.endTime == endTime;
  }

  @override
  int get hashCode {
    return room.hashCode ^
        year.hashCode ^
        day.hashCode ^
        startTime.hashCode ^
        endTime.hashCode;
  }
}
