import 'package:flutter/material.dart';
import 'package:timetable_app/data/models/responses/booking_model.dart';
import 'package:timetable_app/helpers/extensions.dart';

import '../../../../helpers/font_styles.dart';

class BookingWidget extends StatelessWidget {
  final BookingModel booking;
  const BookingWidget({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        elevation: 2.5,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 115,
          width: double.maxFinite,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // color: AppColors.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  width: 96,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    booking.day.substring(0, 3).toUpperCase(),
                    style: bold(22).copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              15.w,
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${booking.course.code} ${booking.course.name}',
                      overflow: TextOverflow.ellipsis,
                      style: bold(18),
                    ),
                    Text(
                      booking.room,
                      style: semiBold(17),
                    ),
                    Text(
                      '${booking.startTime.toTime} - ${booking.endTime.toTime}',
                      style: regular(16),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
