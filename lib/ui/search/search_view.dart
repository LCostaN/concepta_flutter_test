import 'package:concepta_test/state/recent_search_provider.dart';
import 'package:concepta_test/ui/widgets/collapsible_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CollapsibleSearchBar(),
      ),
    );
  }
}
