import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(FoodRecognitionApp());
}

class FoodRecognitionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Recognition',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomeScreen(),
    );
  }
}
