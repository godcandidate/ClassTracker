import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetable_app/controllers/timetime_controller.dart';
import 'package:timetable_app/data/models/responses/timetable_model.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/helpers/font_styles.dart';
import 'package:timetable_app/views/screens/profile/course.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  String selectedDay = 'Monday';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Timetable'),
      ),
      body: GetBuilder<TimetableController>(
        builder: (tController) {
          print(tController.timeTable!.first.toMap());
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday'
                  ].map((e) {
                    return Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedDay = e;
                          });
                        },
                        child: Card(
                          color: selectedDay == e
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              e.substring(0, 3),
                              textAlign: TextAlign.center,
                              style: semiBold(16).copyWith(
                                color: selectedDay == e
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                20.h,
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 120,
                    mainAxisSpacing: 5,
                  ),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: tController.timeTable!
                      .where((element) =>
                          element.day.toLowerCase() ==
                          selectedDay.toLowerCase() && element.recursive)
                      .length,
                  itemBuilder: (context, index) {
                    List<TimetableModel> timetableModel = tController.timeTable!
                        .where((element) =>
                            element.day.toLowerCase() ==
                            selectedDay.toLowerCase() && element.recursive)
                        .toList();
                    timetableModel
                        .sort((a, b) => a.startTime.compareTo(b.startTime));
                    return CourseCard(timetableModel: timetableModel[index]);
                  },
                )
                // Padding(
                //   padding: const EdgeInsets.all(3.0),
                //   child: DataTable(
                //     columnSpacing: 15,
                //     border: TableBorder.all(),
                //     columns: [
                //       // 'Code',
                //       'Course',
                //       'Room',
                //       'Start',
                //       'End',
                //     ].map((e) {
                //       return DataColumn(
                //         label: Text(
                //           e,
                //           style: bold(15),
                //         ),
                //       );
                //     }).toList(),
                //     rows: tController.timeTable!
                //         .where((tt) =>
                //             tt.day.toLowerCase() == selectedDay.toLowerCase())
                //         .map((e) {
                //       return DataRow(
                //           cells: [
                //         // e.course.code,
                //         e.course.name,
                //         e.room.name,
                //         e.startTime.toTime,
                //         e.endTime.toTime
                //       ].map((row) {
                //         return DataCell(
                //           Text(
                //             row,
                //             style: semiBold(14),
                //           ),
                //         );
                //       }).toList());
                //     }).toList(),
                //   ),
                // )
              ],
            ),
          );
        },
      ),
    );
  }
}
