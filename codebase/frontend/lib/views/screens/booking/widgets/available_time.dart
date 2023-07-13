import 'package:flutter/material.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/helpers/font_styles.dart';

import '../../../../helpers/available_times.dart';
import '../../../../helpers/date_formatter.dart';

class AvailableTimes extends StatelessWidget {
  final int index;
  final TimeRange availableTime;
  final int selectedIndex;
  final int selectedDay;
  const AvailableTimes({
    super.key,
    required this.index,
    required this.availableTime,
    required this.selectedIndex,
    required this.selectedDay,
  });

  @override
  Widget build(BuildContext context) {
    bool now = ["00:00", "08:00"].contains(availableTime.start.toString());
    return SizedBox(
      width: 150,
      height: 60,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        borderOnForeground: index == selectedIndex ? true : false,
        elevation: 2.5,
        shape: RoundedRectangleBorder(
          side: index == selectedIndex
              ? BorderSide(
                  color: Theme.of(context).primaryColor,
                )
              : BorderSide.none,
          borderRadius: 10.border,
        ),
        child: Center(
          child: Text(
            '${now ? selectedDay == DateTime.now().day ? DateFormatter.hhmm().toTime : "08:00" : availableTime.start} - ${availableTime.end}',
            style: bold(17).copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
