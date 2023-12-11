import 'package:eventcircle/controllers/event_controller.dart';
import 'package:eventcircle/models/event.dart';
import 'package:eventcircle/screens/widgets/event_item.dart';
import 'package:eventcircle/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/search');
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more),
          ),
        ],
      ),
      body: FutureBuilder<List<Event>>(
        // Fetch events when the widget is built
        future: EventService.fetchEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a circular loading indicator while waiting for the data
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Display an error message if there's an error
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Display a message when there are no events
            return const Center(child: Text('No events available.'));
          } else {
            // Display the events using ListView.builder
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final event = snapshot.data![index];
                return EventItem(event: event);
              },
            );
          }
        },
      ),
    );
  }
}