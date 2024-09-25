import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smartplate/models/food_item_model.dart';
import 'package:smartplate/services/image_recognition_service.dart';


class ResultScreen extends StatefulWidget {
  final String imagePath;

  ResultScreen({required this.imagePath});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Future<List<FoodItem>> _classificationResult;

  @override
  void initState() {
    super.initState();
    _classificationResult = ImageRecognitionService().recognizeFood(widget.imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Result')),
      body: FutureBuilder<List<FoodItem>>(
        future: _classificationResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final foodItems = snapshot.data ?? [];
          return Column(
            children: [
              Image.file(File(widget.imagePath)),
              SizedBox(height: 20),
              Text('Recognition Results:', style: TextStyle(fontSize: 20)),
              ...foodItems.map((item) => ListTile(
                title: Text(item.name),
                subtitle: Text('Confidence: ${item.confidence.toStringAsFixed(2)}'),
              )),
            ],
          );
        },
      ),
    );
  }
}
