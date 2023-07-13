import 'package:flutter/material.dart';
import 'package:timetable_app/data/models/responses/room_status_model.dart';
import 'package:timetable_app/helpers/extensions.dart';
import 'package:timetable_app/utils/navigation.dart';
import 'package:timetable_app/views/screens/booking/widgets/add_booking.dart';

import '../../../../helpers/font_styles.dart';
import 'card_widget.dart';

class AllRoomScreen extends StatefulWidget {
  final String title;
  final List<RoomStatusModel> rooms;
  const AllRoomScreen({
    super.key,
    required this.title,
    required this.rooms,
  });

  @override
  State<AllRoomScreen> createState() => _AllRoomScreenState();
}

class _AllRoomScreenState extends State<AllRoomScreen> {
  late String title;
  late bool occupied;
  late List<RoomStatusModel> rooms;
  @override
  void initState() {
    super.initState();
    title = widget.title;
    occupied = title == 'Available Now' ? false : true;
    rooms = widget.rooms;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: RoomSearchDelegate(
                    rooms: rooms,
                    occupied: occupied,
                  ));
            },
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          )
        ],
      ),
      body: rooms.isEmpty
          ? Center(
              child: Text(
                'No data found',
                style: bold(18),
              ),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!occupied)
                      Text(
                        'The rooms below are available. Tap to make a booking',
                        style: semiBold(16),
                      ),
                    10.h,
                    GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 130,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: rooms.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          return RoomItem(
                            room: rooms[index],
                            occupied: occupied,
                          );
                        }),
                  ],
                ),
              ),
            ),
    );
  }
}

class RoomSearchDelegate extends SearchDelegate {
  final List<RoomStatusModel> rooms;
  final bool occupied;
  RoomSearchDelegate({
    required this.rooms,
    required this.occupied,
  });

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: Theme.of(context).appBarTheme,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Theme.of(context).primaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: rooms.where((element) {
          return element.room.name.toLowerCase().contains(query.toLowerCase());
        }).map((e) {
          return SearchResult(
            room: e,
            onPressed: () => close(context, ''),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: rooms.where((element) {
          if (occupied) {
            return true;
          }
          return query.isEmpty
              ? element.endTime == 0
              : element.room.name.toLowerCase().contains(
                    query.toLowerCase(),
                  );
        }).map((e) {
          return SearchResult(
            room: e,
            occupied: occupied,
            onPressed: () {
              close(context, '');
            },
          );
        }).toList(),
      ),
    );
  }
}

class SearchResult extends StatefulWidget {
  final RoomStatusModel room;
  final bool occupied;
  final void Function() onPressed;
  const SearchResult({
    super.key,
    required this.room,
    required this.onPressed,
    this.occupied = true,
  });

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.room.room.name,
        style: medium(16),
      ),
      onTap: widget.occupied
          ? null
          : () {
              widget.onPressed();
              toScreen(
                context,
                AddBooking(
                  room: widget.room.room.name,
                ),
              );
            },
    );
  }
}
