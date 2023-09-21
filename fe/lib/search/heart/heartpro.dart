import 'package:flutter/foundation.dart';

class LikeButtonProvider extends ChangeNotifier {
  bool _isLiked = false;

  bool get isLiked => _isLiked;

  void toggleLike() {
    _isLiked = !_isLiked;
    notifyListeners();
  }
}
