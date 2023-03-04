import 'dart:convert';

class SearchModel {
  final String text;
  final DateTime date;

  SearchModel({required this.text, required this.date});

  factory SearchModel.fromString(String string) {
    var json = jsonDecode(string);

    String text = json['text'];
    DateTime date = DateTime.parse(json['date']);

    return SearchModel(text: text, date: date);
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    'date': date.toString(),
  };

  @override
  String toString() => jsonEncode(toJson());

  @override
  operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is SearchModel && other.text == text;
  }

  @override
  int get hashCode => super.hashCode + 0;
}
