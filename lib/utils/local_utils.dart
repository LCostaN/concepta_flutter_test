import 'package:concepta_test/model/search_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalUtils {
  static final LocalUtils _instance = LocalUtils._();
  static LocalUtils get instance => _instance;

  LocalUtils._();

  factory LocalUtils() => instance;

  static const _searchListKey = 'searches';

  final Future<SharedPreferences> _pf = SharedPreferences.getInstance();

  Future<void> addSearch(String value) async {
    var list = (await _pf).getStringList(_searchListKey) ?? [];
    var searches =
        list.map((search) => SearchModel.fromString(search)).toSet().toList();

    searches.removeWhere((search) => search.text == value);

    searches.add(SearchModel(text: value, date: DateTime.now()));
    searches.sort((a, b) => a.date.compareTo(b.date) * -1);

    await (await _pf).setStringList(
        _searchListKey, searches.map((s) => s.toString()).toList());
  }

  Future<List<SearchModel>> getSearches() async {
    var list = (await _pf).getStringList(_searchListKey) ?? [];

    var searches =
        list.map((search) => SearchModel.fromString(search)).toSet().toList();

    return searches..sort((a, b) => a.date.compareTo(b.date) * -1);
  }

  Future<void> remove(String text) async {
    var list = (await _pf).getStringList(_searchListKey) ?? [];
    var searches =
        list.map((search) => SearchModel.fromString(search)).toSet().toList();

    searches.removeWhere((search) => search.text == text);
    searches.sort((a, b) => a.date.compareTo(b.date) * -1);

    await (await _pf).setStringList(
        _searchListKey, searches.map((s) => s.toString()).toList());
  }

  Future<void> clear() async {
    await (await _pf).clear();
  }
}
