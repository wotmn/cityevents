import 'package:flutter/material.dart';
import 'package:cityevents/view/EventPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City Events',
      home: EventPage(),
    );
  }
}
