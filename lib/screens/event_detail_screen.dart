import 'package:eventcircle/models/event.dart';
import 'package:eventcircle/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int eventId = Get.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark)),
        ],
      ),
      body: FutureBuilder<Event>(
        future: EventService.fetchEventDetails(eventId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a circular loading indicator while waiting for the data
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Display an error message if there's an error
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            // Display a message when there are no event details
            return const Center(child: Text('No event details available.'));
          } else {
            // Display the event details using the fetched data
            final Event event = snapshot.data!;
            return buildEventDetails(event);
          }
        },
      ),
    );
  }

  Widget buildEventDetails(Event event) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(event.bannerImage),
                const SizedBox(height: 16.0),
                Text(
                  event.title,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Image.network(
                        event.organiserIcon,
                        height: 54,
                        width: 52,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event.organiserName),
                          const Text("Organiser"),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                EventTile(
                  title: DateFormat('dd MMMM, yyyy').format(event.dateTime),
                  subtitle: event.getFormattedTimeDuration(),
                  icon: Icons.calendar_month,
                ),
                EventTile(
                  title: event.venueName,
                  subtitle: "${event.venueCity}, ${event.venueCountry}",
                  icon: Icons.location_pin,
                ),
                const Text(
                  "About event",
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                // ExpandableText(
                //   event.description,
                //   style: const TextStyle(fontSize: 16.0),
                //   expandText: 'Read more',
                //   collapseText: 'Read less',
                //   maxLines: 4,
                // ),
              ],
            ),
          ),
        ),
        Container(
          height: 181,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white24,
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Center(
            child: Container(
              height: 58,
              width: 271,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Expanded(child: Center(child: Text("BOOK NOW"))),
                  IconButton.filledTonal(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EventTile extends StatelessWidget {
  const EventTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF5669FF).withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF5669FF),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text(subtitle),
            ],
          ),
        ],
      ),
    );
  }
}
