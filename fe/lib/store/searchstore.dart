import 'package:flutter/cupertino.dart';

class SearchStore extends ChangeNotifier {
  bool doSearch = false;

  watchSearch() {
    doSearch = !doSearch;
    notifyListeners();
  }
}
