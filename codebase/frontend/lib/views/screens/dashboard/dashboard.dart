import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:timetable_app/controllers/auth_controller.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/helpers/font_styles.dart';
import 'package:timetable_app/utils/images.dart';
import 'package:timetable_app/utils/navigation.dart';
import 'package:timetable_app/views/screens/auth/login.dart';
import 'package:timetable_app/views/screens/booking/booking_screen.dart';
import 'package:timetable_app/views/screens/home/home_screen.dart';
import 'package:timetable_app/views/screens/profile/profile_screen.dart';

import 'all_rooms.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Widget> screens = [
    const HomeScreen(),
    const BookingScreen(),
    const ProfileScreen(),
  ];
  int currentIndex = 0;

  void onPressed(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: currentIndex == 0
            ? null
            : FloatingActionButton(
                onPressed: () async {
                  if (currentIndex == 1) {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return const AllRooms();
                        });
                    // toScreen(context, const AddBooking());
                  } else {
                    replaceScreen(context, const LoginScreen());
                    Future.delayed(const Duration(seconds: 1), () async {
                      await Get.find<AuthController>()
                          .logout()
                          .then((value) {});
                    });
                  }
                },
                shape: currentIndex == 1
                    ? null
                    : const CircleBorder(
                        side: BorderSide(
                          color: Colors.red,
                          width: 2.5,
                        ),
                      ),
                child: currentIndex == 1
                    ? Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                        size: 35,
                      )
                    : SvgPicture.asset(Images.logout),
              ),
        bottomNavigationBar: SizedBox(
          height: 62,
          child: BottomAppBar(
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: BottomChild(
                    iconPath: Images.home,
                    index: 0,
                    selectedIndex: currentIndex,
                    onPresed: (index) => onPressed(index),
                  ),
                ),
                BottomChild(
                  iconPath: Images.booking,
                  index: 1,
                  selectedIndex: currentIndex,
                  onPresed: (index) => onPressed(index),
                ),
                BottomChild(
                  iconPath: Images.profile,
                  index: 2,
                  selectedIndex: currentIndex,
                  onPresed: (index) => onPressed(index),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: Image.asset(
              Images.logo,
              height: 50,
            ),
          ),
          title: Text(
            currentIndex == 0
                ? 'Home'
                : currentIndex == 1
                    ? 'Booking'
                    : 'Profile',
            style: bold(20).copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
      ),
    );
  }
}

class BottomChild extends StatelessWidget {
  final String iconPath;
  final int index;
  final int selectedIndex;
  final void Function(int index) onPresed;

  const BottomChild({
    super.key,
    required this.iconPath,
    required this.index,
    required this.onPresed,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => onPresed(index),
      child: SvgPicture.asset(
        iconPath,
        width: selectedIndex == index ? 40 : 25,
        height: selectedIndex == index ? 40 : 25,
      ),
    );
  }
}
