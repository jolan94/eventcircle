import 'package:eventcircle/screens/event_detail_screen.dart';
import 'package:eventcircle/screens/home_screen.dart';
import 'package:eventcircle/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Event Circle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/eventDetails', page: () => EventDetailScreen()),
        GetPage(name: '/search', page: () => SearchScreen()),
      ],
    );
  }
}
