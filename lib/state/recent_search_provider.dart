import 'package:concepta_test/model/search_model.dart';
import 'package:concepta_test/utils/local_utils.dart';
import 'package:flutter/foundation.dart';

class RecentSearchProvider with ChangeNotifier {
  List<SearchModel> searches = [];

  RecentSearchProvider() {
    refresh();
  }

  void refresh() {
    LocalUtils().getSearches().then((value) {
      searches = value.take(5).toList();
      notifyListeners();
    });
  }
}
