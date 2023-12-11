// services/event_service.dart
import 'dart:convert';
import 'package:eventcircle/models/event.dart';
import 'package:http/http.dart' as http;

class EventService {
  static String baseUrl =
      "https://sde-007.api.assignment.theinternetfolks.works";

  static Future<List<Event>> fetchEvents() async {
    final response = await http.get(Uri.parse("$baseUrl/v1/event"));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData['content']['data'];
      return data.map((event) => Event.fromJson(event)).toList();
    } else {
      throw Exception("Failed to load events");
    }
  }

  static Future<List<Event>> searchEvents({required String searchQuery}) async {
    final Uri uri = Uri.parse("$baseUrl/v1/event?search=$searchQuery");

    // final Map<String, String> queryParams = {'search': searchQuery};
    // final Uri searchUri = uri.replace(queryParameters: queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData['content']['data'];
      return data.map((event) => Event.fromJson(event)).toList();
    } else {
      throw Exception("Failed to load events");
    }
  }

  static Future<Event> fetchEventDetails(int eventId) async {
    final Uri uri = Uri.parse("$baseUrl/v1/event/$eventId");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final Map<String, dynamic> data = jsonData['content']['data'];
      return Event.fromJson(data);
    } else {
      throw Exception("Failed to load event details");
    }
  }
}
