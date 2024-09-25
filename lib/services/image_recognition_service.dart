import 'dart:io';
import 'package:smartplate/models/food_item_model.dart';
import 'package:tflite/tflite.dart';

class ImageRecognitionService {
  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite", // Update with your model path
      labels: "assets/labels.txt",   // Update with your labels path
    );
  }

  Future<List<FoodItem>> recognizeFood(String imagePath) async {
    await loadModel();
    final List<dynamic>? result = await Tflite.runModelOnImage(path: imagePath);

    List<FoodItem> foodItems = [];
    if (result != null) {
      for (var res in result) {
        foodItems.add(FoodItem(name: res['label'], confidence: res['confidence']));
      }
    }
    return foodItems;
  }
}
