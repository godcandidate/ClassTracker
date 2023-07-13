import 'dart:convert';

class LoginBody {
  final int reference;
  final String password;
  LoginBody({
    required this.reference,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'reference': reference,
      'password': password,
    };
  }

  factory LoginBody.fromMap(Map<String, dynamic> map) {
    return LoginBody(
      reference: map['reference'],
      password: map['password'],
    );
  }

  toJson() => toMap();

  factory LoginBody.fromJson(String source) =>
      LoginBody.fromMap(json.decode(source));

  @override
  String toString() => 'LoginBody(reference: $reference, password: $password)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LoginBody && o.reference == reference && o.password == password;
  }

  @override
  int get hashCode => reference.hashCode ^ password.hashCode;
}
