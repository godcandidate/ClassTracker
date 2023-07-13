import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetable_app/controllers/booking_controller.dart';
import 'package:timetable_app/data/models/responses/booking_model.dart';
import 'package:timetable_app/views/base/custom_loader.dart';
import 'package:timetable_app/views/screens/booking/widgets/booking_widget.dart';

import '../../../helpers/font_styles.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(builder: (bookController) {
      if (bookController.bookings == null) {
        return const Center(
          child: CustomLoader(size: 50),
        );
      } else if (bookController.bookings!.isEmpty) {
        return Center(
          child: Text(
            'No data found',
            style: bold(18),
          ),
        );
      } else {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: bookController.bookings!.length,
          itemBuilder: (context, index) {
            BookingModel booking = bookController.bookings![index];
            return BookingWidget(booking: booking);
          },
        );
      }
    });
  }
}
