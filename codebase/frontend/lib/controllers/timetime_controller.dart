import 'package:get/get.dart';
import 'package:timetable_app/data/repository/timetable_repo.dart';
import 'package:timetable_app/helpers/date_formatter.dart';

import '../data/models/responses/timetable_model.dart';

class TimetableController extends GetxController implements GetxService {
  final TimetableRepo timetableRepo;
  TimetableController(this.timetableRepo);

  List<TimetableModel>? _timeTable;
  List<TimetableModel>? get timeTable => _timeTable;

  bool _noClass = false;
  bool get noClass => _noClass;
  // GET TIMETABLE
  List<TimetableModel>? _todayTable;
  List<TimetableModel>? get todayTable => _todayTable;

  Future<void> getTimetable(Map<String, dynamic> query) async {
    Response response = await timetableRepo.getTimetable(query);
    if (response.statusCode == 200) {
      _timeTable = [];
      List body = response.body['timetable'];
      _timeTable = List.generate(
        body.length,
        (index) => TimetableModel.fromMap(body[index]),
      );
      _todayTable = _timeTable!
          .where((element) =>
              element.day.toLowerCase() ==
              DateFormatter.dayFromTime().toLowerCase())
          .toList();
      List<TimetableModel> upComing = _todayTable!.where(
        (element) {
          return element.day.toLowerCase() ==
                  DateFormatter.dayFromTime().toLowerCase() &&
              !(element.endTime < DateFormatter.hhmm());
        },
      ).toList();

      if (upComing.isNotEmpty) {
        _noClass = false;
        getUpcomingClass(upComing);
      } else {
        _noClass = true;
      }
    } else {}
    update();
  }

  // UPCOMING CLASS
  TimetableModel? _upcomingClass;
  TimetableModel? get upcomingClass => _upcomingClass;
  void getUpcomingClass(List<TimetableModel> timings) {
    timings.sort((a, b) {
      return (a.startTime - DateFormatter.hhmm())
          .compareTo(b.startTime - DateFormatter.hhmm());
    });
    _upcomingClass = timings.first;
    if (_upcomingClass!.startTime < DateFormatter.hhmm() &&
        _upcomingClass!.endTime > DateFormatter.hhmm()) {
      _upcomingClass!.ongoing = true;
    }
  }
}
