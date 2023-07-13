import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:timetable_app/data/models/responses/room_status_model.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/helpers/font_styles.dart';
import 'package:timetable_app/utils/images.dart';
import 'package:timetable_app/utils/navigation.dart';
import 'package:timetable_app/views/screens/booking/widgets/add_booking.dart';

class RoomItem extends StatelessWidget {
  final bool occupied;
  final RoomStatusModel room;
  const RoomItem({
    super.key,
    this.occupied = true,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: occupied
          ? null
          : () {
              toScreen(
                  context,
                  AddBooking(
                    room: room.room.name,
                  ));
              // showModalBottomSheet(
              //   shape: const RoundedRectangleBorder(
              //     borderRadius: BorderRadius.vertical(
              //       top: Radius.circular(25),
              //     ),
              //   ),
              //   context: context,
              //   builder: (context) {
              //     return Card(
              //       margin: EdgeInsets.zero,
              //       shape: const RoundedRectangleBorder(
              //         borderRadius: BorderRadius.vertical(
              //           top: Radius.circular(25),
              //         ),
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
              //         child: Column(
              //           children: [
              //             Text(
              //               'Available Times',
              //               style: bold(20),
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // );
            },
      child: SizedBox(
        width: 100,
        child: Card(
          elevation: 2.5,
          shape: RoundedRectangleBorder(
            borderRadius: Dimensions.RadiusMedium.border,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 10, vertical: occupied ? 3 : 12),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: occupied
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.spaceBetween,
                      verticalDirection: occupied
                          ? VerticalDirection.down
                          : VerticalDirection.up,
                      children: [
                        if (occupied) ...[
                          SvgPicture.asset(
                            Images.courseIcon,
                            color: Colors.black,
                            height: 25,
                          ),
                          const Icon(
                            Icons.stop_circle_outlined,
                            color: Colors.red,
                          ),
                        ],
                        if (!occupied)
                          const Icon(
                            Icons.play_circle_outline_outlined,
                            color: Colors.green,
                          ),
                        SvgPicture.asset(
                          Images.roomIcon,
                          color: Colors.black,
                          height: occupied ? null : 30,
                        ),
                      ],
                    ),
                    15.w,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: occupied
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.spaceBetween,
                        verticalDirection: occupied
                            ? VerticalDirection.down
                            : VerticalDirection.up,
                        children: [
                          if (occupied)
                            Text(
                              room.course.code,
                              style: bold(20).copyWith(),
                            ),
                          Text(
                            occupied
                                ? room.endTime.toTime
                                : availableTimes(room),
                            style: medium(18),
                          ),
                          Text(
                            room.room.name,
                            overflow: TextOverflow.ellipsis,
                            style: occupied ? medium(18) : bold(20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (occupied)
                  Lottie.asset(
                    Images.live,
                    height: 30,
                    width: 30,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String availableTimes(RoomStatusModel room) {
  dynamic start = room.startTime;
  int end = room.endTime;
  if (start == 800) {
    start = 'Now';
  }
  return '$start - ${end.toTime}';
}
