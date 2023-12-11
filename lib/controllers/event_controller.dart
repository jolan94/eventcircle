// controllers/event_controller.dart
import 'package:eventcircle/models/event.dart';
import 'package:eventcircle/services/event_service.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  final List<Event> allEvents = <Event>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  void fetchEvents() async {
    try {
      isLoading.value = true;
      final events = await EventService.fetchEvents();
      allEvents.assignAll(events);
    } catch (error) {
      print("Error fetching events: $error");
    } finally {
      isLoading.value = false;
    }
  }

  void searchEvents({required String searchQuery}) async {
    try {
      isLoading.value = true;
      final events = await EventService.searchEvents(searchQuery: searchQuery);
      allEvents.assignAll(events);
    } catch (error) {
      print("Error searching events: $error");
    } finally {
      isLoading.value = false;
    }
  }
}
