import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetable_app/controllers/booking_controller.dart';
import 'package:timetable_app/controllers/courses_controller.dart';
import 'package:timetable_app/controllers/room_controller.dart';
import 'package:timetable_app/controllers/user_controller.dart';
import 'package:timetable_app/data/models/body/booking_body.dart';
import 'package:timetable_app/data/models/responses/course_model.dart';
import 'package:timetable_app/data/models/responses/user_model.dart';
import 'package:timetable_app/helpers/available_times.dart';
import 'package:timetable_app/helpers/date_formatter.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/helpers/font_styles.dart';
import 'package:timetable_app/utils/app_colors.dart';
import 'package:timetable_app/utils/navigation.dart';
import 'package:timetable_app/views/base/custom_loader.dart';
import 'package:timetable_app/views/screens/booking/widgets/available_time.dart';
import 'package:timetable_app/views/screens/booking/widgets/selected_room.dart';

class AddBooking extends StatefulWidget {
  final String room;
  const AddBooking({
    super.key,
    required this.room,
  });

  @override
  State<AddBooking> createState() => _AddBookingState();
}

class _AddBookingState extends State<AddBooking> {
  DateTime selectedDay = DateTime.now();
  int selectedIndex = 0;
  double durationValue = 1;
  TimeRange selectedRange = TimeRange(Time(0, 0), Time(0, 0));
  late List<CourseModel> courses;
  late CourseModel selectedCourse;
  Time? startTime;
  Time? endTime;
  Time? duration;
  @override
  void initState() {
    super.initState();
    courses = Get.find<CourseController>().courses!;
    selectedCourse = courses.first;
    init();
  }

  init() async {
    RoomController rc = Get.find<RoomController>();
    await rc.getRoomAvailableTimes({
      'day': DateFormatter.dayFromTime(selectedDay).toLowerCase(),
      'room': widget.room,
      'time': DateFormatter.hhmm(DateTime.now())
    });
    selectedRange = rc.availableTimes!.first;
    startTime = rc.availableTimes!.first.start;

    print(rc.availableTimes!.first.start);
    if (rc.availableTimes!.first.start.toString() == "08:00") {
      DateTime now = DateTime.now();
      selectedRange.start = Time(now.hour, now.minute);
      startTime = Time(now.hour, now.minute);
    }
    if (rc.availableTimes!.first.start.toString() == "00:00") {}
    setState(() {
      endTime = selectedRange.end;
    });
    // duration = endTime!.subtractTime(startTime!);
  }

  @override
  Widget build(BuildContext context) {
    int days = 5 - DateTime.now().weekday;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Booking'),
      ),
      bottomNavigationBar: InkWell(
        onTap: () async {
          if (!validation().isError!) {
            UserModel user = Get.find<UserController>().user!;
            int start = int.parse(startTime.toString().replaceAll(':', ''));
            int end = int.parse(endTime.toString().replaceAll(':', ''));
            BookingBody bookingBody = BookingBody(
              room: widget.room,
              courseCode: selectedCourse.code,
              year: user.year,
              day: DateFormatter.dayFromTime(selectedDay),
              startTime: start,
              endTime: end,
              reference: user.reference,
            );
            await Get.find<BookingController>().createBooking(bookingBody).then(
              (value) async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      title: Text(
                        value.isSuccess ? 'Congrats!' : 'Oh-ooh',
                        style: bold(18),
                      ),
                      content: Text(
                        value.message,
                        style: semiBold(16).copyWith(
                          color: value.isSuccess ? Colors.green : AppColors.red,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            pop(context);
                            if (value.isSuccess) {
                              pop(context);
                            }
                          },
                          child: const Text('Ok'),
                        )
                      ],
                    );
                  },
                );
                if (value.isSuccess) {
                  await Get.find<BookingController>().getBookings({
                    'reference': user.reference,
                  });
                }
              },
            );
          }
        },
        child: Container(
          color: AppColors.red,
          height: 62,
          alignment: Alignment.center,
          child: Text(
            'Book now',
            style: bold(24).copyWith(color: Colors.white),
          ),
        ),
      ),
      body: GetBuilder<RoomController>(
        builder: (controller) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected Room',
                    style: bold(18).copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  10.h,
                  SelectedRoom(room: widget.room),
                  20.h,
                  Text(
                    'Select day',
                    style: regular(16).copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  5.h,
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: 10.border,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: InkWell(
                      onTap: () async {
                        DateTime selected = await showDatePicker(
                              context: context,
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData(
                                    colorScheme: ColorScheme.light(
                                      primary: Theme.of(context).primaryColor,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: AppColors.red,
                                      ),
                                    ),
                                    dialogTheme: DialogTheme(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: 20.border,
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                              currentDate: selectedDay,
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                              initialDate: selectedDay,
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(Duration(days: days)),
                            ) ??
                            selectedDay;
                        if (selectedDay != selected) {
                          setState(() {
                            selectedDay = selected;
                          });
                          await controller.getRoomAvailableTimes({
                            'day': DateFormatter.dayFromTime(selected)
                                .toLowerCase(),
                            'time': DateFormatter.hhmm(),
                            'room': widget.room,
                          });
                        }
                      },
                      child: Text(
                        selectedDay.day == DateTime.now().day
                            ? 'Today'
                            : DateFormatter.dayFromTime(selectedDay),
                        style: semiBold(18).copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  15.h,
                  Text(
                    'Available times',
                    style: regular(16).copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  5.h,
                  controller.availableTimes == null
                      ? const Center(child: CustomLoader())
                      : GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 60,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                          ),
                          itemCount: controller.availableTimes!.length,
                          itemBuilder: ((context, index) {
                            TimeRange availableTime =
                                controller.availableTimes![index];
                            // selectedRange = controller.availableTimes!.first;

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  selectedRange = availableTime;
                                  if (availableTime.start.toString() ==
                                      "08:00") {
                                    startTime = Time.fromString(
                                      DateFormatter.hhmm().toTime,
                                    );
                                  } else if (availableTime.start.toString() ==
                                      "00:00") {
                                    startTime = Time.fromString("08:00");
                                  } else {
                                    startTime = selectedRange.start;
                                  }
                                  endTime = availableTime.end;
                                  duration = endTime!.subtractTime(startTime!);
                                });
                              },
                              child: AvailableTimes(
                                selectedDay: selectedDay.day,
                                availableTime: availableTime,
                                index: index,
                                selectedIndex: selectedIndex,
                              ),
                            );
                          }),
                        ),
                  15.h,
                  DropdownButtonFormField(
                    value: selectedCourse,
                    iconEnabledColor: Theme.of(context).primaryColor,
                    items: courses.map((course) {
                      return DropdownMenuItem(
                        value: course,
                        child: Text(
                          course.name,
                          style: bold(16)
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCourse = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Course',
                      labelStyle: semiBold(18).copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  if (endTime != null) ...[
                    15.h,
                    Row(
                      children: [
                        Text(
                          'From',
                          style: bold(18).copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        10.w,
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: 10.border,
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          child: InkWell(
                            onTap: () async {
                              TimeOfDay? startTimePicked = await showTimePicker(
                                context: context,
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData(
                                      colorScheme: ColorScheme.light(
                                        primary: Theme.of(context).primaryColor,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: AppColors.red,
                                        ),
                                      ),
                                      dialogTheme: DialogTheme(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: 20.border,
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                                initialTime: TimeOfDay(
                                  hour: int.parse(startTime!.h.toString()),
                                  minute: int.parse(startTime!.m.toString()),
                                ),
                              );
                              if (startTimePicked != null) {
                                setState(() {
                                  startTime = Time(startTimePicked.hour,
                                      startTimePicked.minute);
                                });
                              }
                            },
                            child: Text(
                              startTime.toString(),
                              style: semiBold(18).copyWith(
                                color: Theme.of(context).primaryColor,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'To',
                          style: bold(18).copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        10.w,
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: 10.border,
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          child: InkWell(
                            onTap: () async {
                              TimeOfDay? endTimePicked = await showTimePicker(
                                context: context,
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData(
                                      colorScheme: ColorScheme.light(
                                        primary: Theme.of(context).primaryColor,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: AppColors.red,
                                        ),
                                      ),
                                      dialogTheme: DialogTheme(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: 20.border,
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                                initialTime: TimeOfDay(
                                  hour: int.parse(endTime!.h.toString()),
                                  minute: int.parse(endTime!.m.toString()),
                                ),
                              );
                              if (endTime != null) {
                                setState(() {
                                  endTime = Time(endTimePicked!.hour,
                                      endTimePicked.minute);
                                });
                              }
                            },
                            child: Text(
                              endTime.toString(),
                              style: semiBold(18).copyWith(
                                color: Theme.of(context).primaryColor,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    10.h,
                    Text(
                      'Duration: ${timeDiff(endTime!.subtractTime(startTime!))}',
                      style: semiBold(18).copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    if (validation().isError!) ...[
                      20.h,
                      Center(
                        child: Text(
                          validation().message ?? '',
                          textAlign: TextAlign.center,
                          style: bold(20).copyWith(
                            color: AppColors.red,
                          ),
                        ),
                      ),
                    ]
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ErrorMessage valid = ErrorMessage(isError: false);

  String timeDiff(Time diff) {
    String hrs = '${diff.h} hr';
    String mins = '${diff.m} min';
    if (diff.h > 1) {
      hrs += 's';
    }
    if (diff.m > 1) {
      mins += 's';
    }
    return '${diff.h > 0 ? hrs : ''} ${diff.m > 0 ? mins : ''}';
  }

  ErrorMessage validation() {
    // end > start
    if (endTime!.subtractTime(startTime!).h < 0) {
      return ErrorMessage(
          isError: true,
          message: 'Closing time cannot be greater than Starting time');
    }
    // times not in range
    if (startTime! < selectedRange.start || selectedRange.end < endTime!) {
      return ErrorMessage(
          isError: true, message: 'Selected time outside range');
    }
    // more than 2 hours
    if (endTime!.subtractTime(startTime!).h >= 2 &&
        endTime!.subtractTime(startTime!).m > 0) {
      return ErrorMessage(
          isError: true, message: 'Duration cannot be more than 2 hours');
    }
    // more than 30 minutes
    if (endTime!.subtractTime(startTime!).m < 30 &&
        endTime!.subtractTime(startTime!).h == 0) {
      return ErrorMessage(
          isError: true, message: 'Duration cannot be less than 30 minutes');
    }
    return ErrorMessage(isError: false);
  }
}

class ErrorMessage {
  final String? message;
  final bool? isError;
  ErrorMessage({this.isError, this.message});
}
