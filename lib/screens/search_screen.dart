import 'package:eventcircle/controllers/event_controller.dart';
import 'package:eventcircle/screens/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class SearchScreen extends StatelessWidget {
  final EventController eventController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: GoogleFonts.inter(
            color: const Color(0xFF120D26),
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                // Call the searchEvents method when the text in the search field changes
                eventController.searchEvents(searchQuery: value);
              },
              decoration: InputDecoration(
                hintText: 'Type event name...',
                prefixIcon: const Icon(Iconsax.search_normal),
                border: InputBorder.none,
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF120D26),
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (eventController.isLoading.value) {
                // Display a circular loading indicator while waiting for the data
                return const Center(child: CircularProgressIndicator());
              } else {
                // Display the events using ListView.builder
                return ListView.builder(
                  itemCount: eventController.allEvents.length,
                  itemBuilder: (context, index) {
                    final event = eventController.allEvents[index];
                    return EventItem(event: event);
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
