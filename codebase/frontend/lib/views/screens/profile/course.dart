import 'package:flutter/material.dart';
import 'package:timetable_app/data/models/responses/timetable_model.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/helpers/font_styles.dart';

class CourseCard extends StatelessWidget {
  final TimetableModel timetableModel;
  const CourseCard({
    super.key,
    required this.timetableModel,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Color.fromRGBO(timetableModel.startTime - 60,
        timetableModel.endTime - 100, timetableModel.hashCode + 50, 1);
    return SizedBox(
      height: 100,
      width: 100,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              height: double.maxFinite,
              width: 8,
              decoration: BoxDecoration(
                color: color,
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(30)),
              ),
            ),
            10.w,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    timetableModel.course.name,
                    overflow: TextOverflow.ellipsis,
                    style: bold(15).copyWith(color: color),
                  ),
                  5.h,
                  Text(
                    timetableModel.room.name,
                    style: semiBold(15).copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  5.h,
                  Text(
                    '${timetableModel.startTime.toTime} - ${timetableModel.endTime.toTime}',
                    style: bold(14.5).copyWith(
                      color: color,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
