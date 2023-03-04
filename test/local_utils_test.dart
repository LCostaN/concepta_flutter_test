import 'package:concepta_test/model/search_model.dart';
import 'package:concepta_test/utils/local_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  TestWidgetsFlutterBinding.ensureInitialized();

  late LocalUtils utils;

  setUp(() {
    utils = LocalUtils();
  });

  tearDown(() {
    utils.clear();
  });

  group("Local persistence", () {
    test('write values to local list', () async {
      await utils.addSearch('teste');

      var data = await utils.getSearches();

      expect(data.isNotEmpty, true);
      expect(data[0], SearchModel(text: 'teste', date: DateTime.now()));
    });

    test(
        'when adding a value, should add as first element. If the'
        'element existed previously, should remove the old value.', () async {
      var data = await utils.addSearch('teste').then((value) => utils.getSearches());

      expect(data.isNotEmpty, true);
      expect(data[0], SearchModel(text: 'teste', date: DateTime.now()));

      data = await utils.addSearch('teste2').then((value) => utils.getSearches());

      expect(data[0], SearchModel(text: 'teste2', date: DateTime.now()));
      expect(data[1], SearchModel(text: 'teste', date: DateTime.now()));

      data = await utils.addSearch('teste').then((value) => utils.getSearches());

      expect(data[0], SearchModel(text: 'teste', date: DateTime.now()));
      expect(data[1], SearchModel(text: 'teste2', date: DateTime.now()));
      expect(data.length, 2);
    });

    test('searches must be ordered by most recent one to oldest one', () async {
      await utils.addSearch('teste');
      await Future.delayed(const Duration(seconds: 1)).then((value) => utils.addSearch('teste2')); 
      await Future.delayed(const Duration(seconds: 1)).then((value) => utils.addSearch('teste3')); 
      await Future.delayed(const Duration(seconds: 1)).then((value) => utils.addSearch('teste')); 
      await Future.delayed(const Duration(seconds: 1)).then((value) => utils.addSearch('teste4')); 
      await Future.delayed(const Duration(seconds: 1)).then((value) => utils.addSearch('teste5')); 
      await Future.delayed(const Duration(seconds: 1)).then((value) => utils.addSearch('teste')); 
      await Future.delayed(const Duration(seconds: 1)).then((value) => utils.addSearch('teste6')); 
      await Future.delayed(const Duration(seconds: 1)).then((value) => utils.addSearch('teste0')); 

      var data = await utils.getSearches();

      for (var i = 0; i < data.length; i++) {
        if (i == 0) continue;

        expect(data[i - 1].date.isAfter(data[i].date), true);
      }
    });

    test('remove the specified text from list', () async {
      await utils.remove('teste');
    });
  });
}
