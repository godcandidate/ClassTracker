import 'dart:convert';

class CourseModel {
  final String code;
  final String name;
  CourseModel({
    required this.code,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      code: map['code'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source));

  @override
  String toString() => 'CourseModel(code: $code, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CourseModel && o.code == code && o.name == name;
  }

  @override
  int get hashCode => code.hashCode ^ name.hashCode;
}
