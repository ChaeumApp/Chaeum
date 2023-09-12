import 'package:flutter/material.dart';

class HeartProvider with ChangeNotifier {
  bool animatedHeart = false;

  void onHeartTap() {
    animatedHeart = !animatedHeart; 
    notifyListeners(); 
  }
}
