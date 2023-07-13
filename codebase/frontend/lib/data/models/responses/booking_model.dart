import 'dart:convert';

import 'package:timetable_app/data/models/responses/course_model.dart';

class BookingModel {
  final int id;
  final int reference;
  final String day;
  final int startTime;
  final int endTime;
  final String room;
  final CourseModel course;
  BookingModel({
    required this.id,
    required this.reference,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.course,
  });

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'reference': reference,
      'day': day,
      'start_time': startTime,
      'end_time': endTime,
      'room': room,
      'course': course.toMap(),
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['ID'],
      reference: map['reference'],
      day: map['day'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      room: map['room'],
      course: CourseModel.fromMap(map['course_details']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookingModel(id: $id, reference: $reference, day: $day, startTime: $startTime, endTime: $endTime, room: $room, course: $course)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BookingModel &&
        o.id == id &&
        o.reference == reference &&
        o.day == day &&
        o.startTime == startTime &&
        o.endTime == endTime &&
        o.room == room &&
        o.course == course;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reference.hashCode ^
        day.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        room.hashCode ^
        course.hashCode;
  }
}
