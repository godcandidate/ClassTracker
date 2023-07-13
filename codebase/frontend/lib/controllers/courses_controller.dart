import 'package:get/get.dart';
import 'package:timetable_app/data/models/responses/course_model.dart';

import '../data/repository/course_repo.dart';

class CourseController extends GetxController implements GetxService {
  final CourseRepo courseRepo;
  CourseController(this.courseRepo);

  // COURSES
  List<CourseModel>? _courses;
  List<CourseModel>? get courses => _courses;

  Future<void> getCourses(Map<String, dynamic> query) async {
    Response response = await courseRepo.getCourses(query);
    if (response.statusCode == 200) {
      List<dynamic> body = response.body['courses'];
      _courses = [];
      _courses = List.generate(
        body.length,
        (index) => CourseModel.fromMap(
          body[index]['course_details'],
        ),
      );
    } else {}
    update();
  }
}
