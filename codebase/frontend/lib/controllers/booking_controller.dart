import 'package:get/get.dart';
import 'package:timetable_app/data/models/body/booking_body.dart';
import 'package:timetable_app/data/models/responses/booking_model.dart';
import 'package:timetable_app/data/models/responses/response_model.dart';

import '../data/repository/booking_repo.dart';

class BookingController extends GetxController implements GetxService {
  final BookingRepo bookingRepo;
  BookingController(this.bookingRepo);

  bool _creating = false;
  bool get creating => _creating;

  // Add booking
  Future<ResponseModel> createBooking(BookingBody bookingBody) async {
    _creating = true;
    update();
    ResponseModel responseModel;

    Response response = await bookingRepo.addBooking(bookingBody);
    // Response response = await bookingRepo.addBooking(bookingBody);
    print(response.body);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(
        true,
        'Your booking has been sucessfully made\nEnjoy your lessons.',
      );
    } else {
      String error = response.body['error'];
      if (error.contains("schedules_pkey")) {
        error = 'Booking already exists';
      }
      responseModel = ResponseModel(false, error);
    }
    _creating = false;
    update();
    return responseModel;
  }

  // Get user bookings
  List<BookingModel>? _bookings;
  List<BookingModel>? get bookings => _bookings;
  Future<void> getBookings(Map<String, dynamic> query) async {
    Response response = await bookingRepo.getUserBookings(query);
    if (response.statusCode == 200) {
      List<dynamic> body = response.body['bookings'];
      _bookings = [];
      _bookings = List.generate(
          body.length, (index) => BookingModel.fromMap(body[index]));
    } else {}
    update();
  }
}
