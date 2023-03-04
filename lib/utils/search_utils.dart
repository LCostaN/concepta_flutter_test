import 'package:concepta_test/model/package_info.dart';
import 'package:pub_api_client/pub_api_client.dart';

class SearchUtils {
  static final SearchUtils _instance = SearchUtils._();
  static SearchUtils get instance => _instance;

  SearchUtils._();

  factory SearchUtils() => instance;

  final _client = PubClient();

  Future<List<String>> search(String text) async {
    var result = await _client.search(text);

    return result.packages.map((r) => r.package).take(6).toList();
  }

  Future<PackageInfo> getDataFor(String packageName) async {
    var result = await _client.packageInfo(packageName);
    var score = await _client.packageScore(packageName);

    var info = PackageInfo(
      name: result.name,
      description: result.description,
      likes: score.likeCount,
      pubpoints: score.grantedPoints ?? 0,
      popularity: ((score.popularityScore ?? 0) * 100).round(),
    );

    return info;
  }
}
