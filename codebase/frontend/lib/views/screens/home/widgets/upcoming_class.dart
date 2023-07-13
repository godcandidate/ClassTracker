import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timetable_app/controllers/timetime_controller.dart';
import 'package:timetable_app/helpers/date_formatter.dart';
import 'package:timetable_app/helpers/extensions.dart';

import '../../../../helpers/font_styles.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/images.dart';

class UpcomingClass extends StatelessWidget {
  const UpcomingClass({super.key});

  @override
  Widget build(BuildContext context) {
    String day = DateFormatter.shortDay();
    String date = DateFormatter.date();
    return GetBuilder<TimetableController>(builder: (tableController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${tableController.upcomingClass != null && tableController.upcomingClass!.onGoing ? 'Ongoing' : 'Upcoming'} class',
            style: medium(16),
          ),
          10.h,
          tableController.upcomingClass != null ||
                  tableController.noClass == true
              ? Container(
                  height: 115,
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: tableController.noClass
                      ? Text(
                          'Hurray! you are done for the day\nGo home and rest',
                          style: bold(20).copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 96,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${day.toUpperCase()}\n${date.padLeft(2, '0')}',
                                    style:
                                        bold(24).copyWith(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                15.w,
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tableController
                                              .upcomingClass!.course.code,
                                          style: medium(16).copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        Text(
                                          tableController
                                              .upcomingClass!.course.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: semiBold(16).copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${tableController.upcomingClass!.startTime.toTime} - ${tableController.upcomingClass!.endTime.toTime}',
                                          style: regular(14).copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        Text(
                                          '${tableController.upcomingClass!.room.name}, ${tableController.upcomingClass!.room.location.name.toUpperCase()}',
                                          style: medium(15).copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SvgPicture.asset(Images.bubble)
                          ],
                        ),
                )
              : Shimmer.fromColors(
                  baseColor: AppColors.secondary.withOpacity(0.3),
                  highlightColor: AppColors.secondary,
                  child: Container(
                    // color: Colors.grey,
                    height: 115,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
        ],
      );
    });
  }
}
