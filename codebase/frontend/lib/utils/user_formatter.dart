import 'package:timetable_app/data/models/responses/user_model.dart';

String userFullname(UserModel user) {
  String middleName = user.middleName!.isEmpty ? '' : ' ${user.middleName}';
  return '${user.firstName}$middleName ${user.surname}';
}
