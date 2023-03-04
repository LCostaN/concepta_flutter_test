
import 'dart:math';

import 'package:concepta_test/model/search_model.dart';
import 'package:concepta_test/ui/widgets/collapsible_search_item.dart';
import 'package:flutter/material.dart';

class CollapsibleSearchOptions extends StatelessWidget {
  const CollapsibleSearchOptions({
    super.key,
    required this.searchResult,
    required this.recentSearches,
    required this.showRecent,
  });

  final List searchResult;
  final List<SearchModel> recentSearches;
  final bool showRecent;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: showRecent
          ? recentSearches.length + 1
          : max(searchResult.length, 1),
      itemBuilder: (context, i) {
        if (i == 0) {
          return showRecent
              ? SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      recentSearches.isEmpty
                          ? "No Recent Searches"
                          : "Recent Searches",
                    ),
                  ),
                )
              : searchResult.isEmpty
                  ? Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("No Results Found"))
                  : CollapsibleSearchItem(text: searchResult[i]);
        }

        return CollapsibleSearchItem(
          text: showRecent ? recentSearches[i - 1].text : searchResult[i],
        );
      },
      separatorBuilder: (_, __) => const Divider(),
    );
  }
}