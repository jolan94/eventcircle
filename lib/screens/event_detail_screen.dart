import 'package:eventcircle/models/event.dart';
import 'package:eventcircle/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EventDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int eventId = Get.arguments as int;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Event Details',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(
                Icons.bookmark,
              )),
        ],
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black
                        .withOpacity(0.1), // Adjust the opacity as needed
                    BlendMode.srcOver,
                  ),
                  child: Image.network(
                    event.bannerImage,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    event.title,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF120D26),
                      fontWeight: FontWeight.w400,
                      fontSize: 35,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
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
                          Text(
                            event.organiserName,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF0D0C26),
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "Organiser",
                            style: GoogleFonts.inter(
                              color: const Color(0xFF706E8F),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
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
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "About event",
                    style: GoogleFonts.inter(
                      color: const Color(0xFF120D26),
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    event.description,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF120D26),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 150,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white24,
                Colors.white10,
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
                color: const Color(0xFF5669FF),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Center(
                          child: Text(
                    "BOOK NOW",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ))),
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: const Color(0xFF3D56F0),
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  )
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
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
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
              Text(
                title,
                style: GoogleFonts.inter(
                  color: const Color(0xFF0D0C26),
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  color: const Color(0xFF706E8F),
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
