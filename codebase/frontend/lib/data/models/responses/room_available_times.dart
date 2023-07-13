import 'dart:convert';

class RoomAvailableTime {
  final String day;
  final int startTime;
  final int endTime;
  RoomAvailableTime({
    required this.startTime,
    required this.endTime,
    required this.day,
  });

  Map<String, dynamic> toMap() {
    return {
      'start_time': startTime,
      'end_time': endTime,
      'day': day,
    };
  }

  factory RoomAvailableTime.fromMap(Map<String, dynamic> map) {
    return RoomAvailableTime(
      day: map['day'],
      startTime: map['start_time'],
      endTime: map['end_time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomAvailableTime.fromJson(String source) =>
      RoomAvailableTime.fromMap(json.decode(source));

  @override
  String toString() =>
      'RoomAvailableTime(startTime: $startTime, endTime: $endTime)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RoomAvailableTime &&
        o.startTime == startTime &&
        o.endTime == endTime;
  }

  @override
  int get hashCode => startTime.hashCode ^ endTime.hashCode;
}
