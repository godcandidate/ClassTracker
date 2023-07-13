class Errors {
  final String code;
  final String message;

  const Errors({required this.code, required this.message});

  factory Errors.fromJson(dynamic json) {
    return Errors(code: json["code"], message: json["message"]);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = code;
    map["message"] = message;
    return map;
  }
}
