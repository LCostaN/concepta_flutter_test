import 'package:concepta_test/model/search_model.dart';
import 'package:concepta_test/utils/local_utils.dart';
import 'package:flutter/foundation.dart';

class SearchProvider with ChangeNotifier {
  List<SearchModel> searches = [];
  bool _isOpen = false;
  bool get isOpen => _isOpen;
  set isOpen(bool value) {
    _isOpen = value;
    notifyListeners();
  }

  SearchProvider() {
    refresh();
  }

  void refresh() {
    LocalUtils().getSearches().then((value) {
      searches = value.take(5).toList();
      notifyListeners();
    });
  }
}
