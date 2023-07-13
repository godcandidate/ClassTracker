import 'dart:convert';

enum RoomType { classRoom, other }

enum RoomLocation { engineering, other }

class RoomModel {
  final String name;
  final int size;
  final RoomType type;
  final RoomLocation location;
  RoomModel({
    required this.name,
    required this.size,
    required this.location,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'room_name': name,
      'size': size,
      'type': type,
      'location': location,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    String room = map['room_name'].toString().split("/").first;
    return RoomModel(
      name: room,
      size: map['size'],
      type: map['type'] == 'class' ? RoomType.classRoom : RoomType.other,
      location: map['location'].toLowerCase() == 'engineering'
          ? RoomLocation.engineering
          : RoomLocation.other,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));

  @override
  String toString() => 'RoomModel(name: $name, size: $size)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RoomModel && o.name == name && o.size == size;
  }

  @override
  int get hashCode => name.hashCode ^ size.hashCode;
}
