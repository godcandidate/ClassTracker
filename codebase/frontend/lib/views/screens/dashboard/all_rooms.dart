import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetable_app/controllers/room_controller.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/helpers/font_styles.dart';
import 'package:timetable_app/utils/navigation.dart';

import '../../../data/models/responses/room_model.dart';
import '../booking/widgets/add_booking.dart';

class AllRooms extends StatefulWidget {
  const AllRooms({
    Key? key,
  }) : super(key: key);

  @override
  State<AllRooms> createState() => _AllRoomsState();
}

class _AllRoomsState extends State<AllRooms> {
  RoomModel? selectedRoom;

  @override
  void initState() {
    super.initState();
    selectedRoom = Get.find<RoomController>().rooms!.first;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(builder: (rc) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Room',
                style: bold(20).copyWith(color: Theme.of(context).primaryColor),
              ),
              20.h,
              Wrap(
                children: rc.rooms!.map((room) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedRoom = room;
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: room.name == selectedRoom!.name
                          ? Theme.of(context).primaryColor
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(room.name,
                            style: room.name == selectedRoom!.name
                                ? bold(16).copyWith(
                                    color: Colors.white,
                                  )
                                : regular(15).copyWith(
                                    color: Theme.of(context).primaryColor,
                                  )),
                      ),
                    ),
                  );
                }).toList(),
              ),
              10.h,
              TextButton(
                onPressed: () {
                  pop(context);

                  toScreen(
                    context,
                    AddBooking(room: selectedRoom!.name),
                  );
                },
                child: const Text('PROCEED'),
              )
            ],
          ),
        ),
      );
    });
  }
}
