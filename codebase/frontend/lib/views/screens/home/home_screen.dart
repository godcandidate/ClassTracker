import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetable_app/controllers/booking_controller.dart';
import 'package:timetable_app/controllers/courses_controller.dart';
import 'package:timetable_app/controllers/room_controller.dart';
import 'package:timetable_app/controllers/timetime_controller.dart';
import 'package:timetable_app/controllers/user_controller.dart';
import 'package:timetable_app/data/models/responses/user_model.dart';
import 'package:timetable_app/helpers/date_formatter.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/helpers/font_styles.dart';
import 'package:timetable_app/utils/images.dart';
import 'package:timetable_app/utils/navigation.dart';
import 'package:timetable_app/utils/user_formatter.dart';
import 'package:timetable_app/views/base/custom_loader.dart';
import 'package:timetable_app/views/screens/home/widgets/all_rooms.dart';
import 'package:timetable_app/views/screens/home/widgets/card_widget.dart';
import 'package:timetable_app/views/screens/home/widgets/title_widget.dart';

import 'widgets/upcoming_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    init(true);
  }

  init(bool reload) async {
    UserModel user = Get.find<UserController>().user!;
    if (reload) {
      await Get.find<RoomController>().fetchAllRooms();
      await Get.find<CourseController>().getCourses({
        'programme': user.programme,
        'year': user.year,
      });
      await Get.find<BookingController>().getBookings({
        'reference': user.reference,
      });
    }
    await Get.find<RoomController>().fetchLiveRooms({
      'time': DateFormatter.hhmm(),
      'day': DateFormatter.dayFromTime(),
    });
    await Get.find<RoomController>().fetchEmptyRooms({
      'time': DateFormatter.hhmm(),
      'day': DateFormatter.dayFromTime().toLowerCase(),
    });
    await Get.find<TimetableController>().getTimetable(
      {
        'programme':user.programme,
        'year': user.year,
        // 'day': DateFormatter.dayFromTime().toLowerCase()
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // init();
    Timer.periodic(const Duration(minutes: 2), (t) async {
      init(false);
    });
    String greeting = '';
    int hour = DateTime.now().hour;
    if (hour >= 0 && hour < 12) {
      greeting = 'Morning';
    } else if (hour >= 12 && hour < 16) {
      greeting = 'Afternoon';
    } else if (hour >= 16) {
      greeting = 'Evening';
    }
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<UserController>(builder: (userController) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Good $greeting\n',
                                      style: medium(16).copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: userFullname(userController.user!),
                                      style: bold(24).copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Image.asset(
                              Images.profilePicture,
                              width: 60,
                              height: 60,
                            ),
                          ],
                        );
                      }),
                      15.h,
                      const UpcomingClass(),
                    ],
                  ),
                ),
              ),
            ),
            10.h,
            GetBuilder<RoomController>(
              builder: (roomController) {
                return Column(
                  children: [
                    TitleWidget(
                      title: 'Ongoing Sessions',
                      onPressed: () {
                        toScreen(
                          context,
                          AllRoomScreen(
                            title: 'Ongonig Sessions',
                            rooms: roomController.liveRooms!,
                          ),
                        );
                      },
                    ),
                    roomController.liveRooms != null
                        ? roomController.liveRooms!.isNotEmpty
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 130,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                                itemCount: roomController.liveRooms!.length > 4
                                    ? 4
                                    : roomController.liveRooms!.length,
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) {
                                  return RoomItem(
                                    room: roomController.liveRooms![index],
                                  );
                                })
                            : Center(
                                child: Text(
                                  'No data found',
                                  style: bold(18),
                                ),
                              )
                        : const Center(
                            child: CustomLoader(),
                          ),
                    TitleWidget(
                      title: 'Available Now',
                      onPressed: () {
                        toScreen(
                          context,
                          AllRoomScreen(
                            title: 'Available Now',
                            rooms: roomController.emptyRooms!,
                          ),
                        );
                      },
                    ),
                    roomController.emptyRooms != null
                        ? roomController.emptyRooms!.isNotEmpty
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 130,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                                itemCount: roomController.emptyRooms!.length > 4
                                    ? 4
                                    : roomController.emptyRooms!.length,
                                // itemCount: roomController.emptyRooms!.length,
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) {
                                  return RoomItem(
                                    room: roomController.emptyRooms![index],
                                    occupied: false,
                                  );
                                })
                            : Center(
                                child: Text(
                                  'No data found',
                                  style: bold(18),
                                ),
                              )
                        : const Center(
                            child: CustomLoader(),
                          ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
