import 'dart:convert';

class UserModel {
  final int reference;
  final String firstName;
  final String? middleName;
  final String surname;
  final int year;
  final String profilePicture;
  final int notification;
  final String programme;
  final int role;
  UserModel({
    required this.reference,
    required this.firstName,
    this.middleName,
    required this.surname,
    required this.year,
    required this.profilePicture,
    required this.notification,
    required this.programme,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'reference': reference,
      'first_name': firstName,
      'middle_name': middleName ?? '',
      'surname': surname,
      'year': year,
      'profile_picture': profilePicture,
      'notification': notification,
      'programme_name': programme,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      reference: map['reference'],
      firstName: map['first_name'],
      middleName: map['middle_name'],
      surname: map['surname'],
      year: map['year'],
      profilePicture: map['profile_picture'],
      notification: map['notification'],
      programme: map['programme_name'],
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(reference: $reference, firstName: $firstName, middleName: $middleName, surname: $surname, year: $year, profilePicture: $profilePicture, notification: $notification, programme: $programme, role: $role)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserModel &&
        o.reference == reference &&
        o.firstName == firstName &&
        o.middleName == middleName &&
        o.surname == surname &&
        o.year == year &&
        o.profilePicture == profilePicture &&
        o.notification == notification &&
        o.programme == programme &&
        o.role == role;
  }

  @override
  int get hashCode {
    return reference.hashCode ^
        firstName.hashCode ^
        middleName.hashCode ^
        surname.hashCode ^
        year.hashCode ^
        profilePicture.hashCode ^
        notification.hashCode ^
        programme.hashCode ^
        role.hashCode;
  }
}
