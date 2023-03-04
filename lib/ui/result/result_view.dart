import 'package:concepta_test/model/package_info.dart';
import 'package:concepta_test/utils/search_utils.dart';
import 'package:flutter/material.dart';

class ResultView extends StatefulWidget {
  const ResultView({super.key, required this.package});

  final String package;

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  late Future<PackageInfo> searchResult;

  @override
  void initState() {
    super.initState();
    searchResult = loadData();
  }

  Future<PackageInfo> loadData() {
    return SearchUtils().getDataFor(widget.package);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.5,
                    color: Theme.of(context).primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const BackButton(),
              ),
              FutureBuilder(
                  future: searchResult,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    var package = snapshot.data;

                    return Card(
                      margin: const EdgeInsets.only(top: 12),
                      child: SizedBox(
                        height: 190,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.fromLTRB(24, 18, 24, 8),
                              child: Text(
                                package!.name,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            const Divider(),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${package.likes}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${package.pubpoints}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${package.popularity}%",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "LIKES",
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "PUB POINTS",
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "POPULARITY",
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                              child: Text(
                                package.description,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
