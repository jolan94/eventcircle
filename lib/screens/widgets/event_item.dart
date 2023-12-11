import 'package:eventcircle/models/event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventItem extends StatelessWidget {
  const EventItem({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/eventDetails', arguments: event.id);
      },
      child: Container(
        decoration: const BoxDecoration(),
        child: Row(
          children: [
            Image.network(
              event.organiserIcon,
              width: 75,
              fit: BoxFit.fitWidth,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.getFormattedDateTime()),
                Text(event.title),
                Text("${event.venueName} • ${event.venueCity}")
              ],
            )
          ],
        ),
      ),
    );
  }
}
