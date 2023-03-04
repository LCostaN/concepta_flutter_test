import 'dart:convert';

import 'package:concepta_test/model/search_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  var text = 'text';
  var date = DateTime.now();
  var testString = jsonEncode({'text': text, 'date': date.toString()});

  group("SearchModel", () {
    test('must accept a stringfied json with text and date parameters', () {
      var model = SearchModel.fromString(testString);

      expect(model.text, text);
      expect(model.date, date);
    });

    test('toString() must create a stringified json', () async {
      var model = SearchModel(text: text, date: date);

      expect(model.text, text);
      expect(model.date, date);

      var modelString = model.toString();

      expect(modelString, testString);
    });
  });
}
