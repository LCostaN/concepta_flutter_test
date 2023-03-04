import 'package:concepta_test/state/recent_search_provider.dart';
import 'package:concepta_test/ui/widgets/collapsible_search_options.dart';
import 'package:concepta_test/utils/search_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollapsibleSearchBar extends StatefulWidget {
  const CollapsibleSearchBar({super.key});

  @override
  State<CollapsibleSearchBar> createState() => CollapsibleSearchBarState();
}

class CollapsibleSearchBarState extends State<CollapsibleSearchBar> {
  FocusNode formFocusNode = FocusNode();

  ValueNotifier<bool> loadNotifier = ValueNotifier(false);
  ValueNotifier<List<String>> searchResult = ValueNotifier([]);

  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    formFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  void search() async {
    loadNotifier.value = true;
    if (searchController.text.length > 1) {
      searchResult.value = await SearchUtils().search(searchController.text);
    } else {
      searchResult.value = [];
    }
    loadNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, provider, _) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            height: 64,
            width: provider.isOpen ? 300 : 64,
            padding: EdgeInsets.symmetric(horizontal: provider.isOpen ? 20 : 0),
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 400),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.5,
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(32),
            ),
            child: provider.isOpen
                ? TextFormField(
                    controller: searchController,
                    focusNode: formFocusNode..requestFocus(),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => provider.isOpen = false,
                      ),
                    ),
                    onChanged: (_) {
                      if (kIsWeb) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Web not supported")),
                        );

                        return;
                      }

                      search();
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => provider.isOpen = true,
                  ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            curve: provider.isOpen
                ? const Interval(0.6, 1)
                : const Interval(0, 0.2),
            opacity: provider.isOpen ? 1 : 0,
            child: Card(
              child: SizedBox(
                width: 300,
                child: ValueListenableBuilder(
                  valueListenable: loadNotifier,
                  builder: (context, isLoading, _) => isLoading
                      ? Center(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: const CircularProgressIndicator(),
                          ),
                        )
                      : CollapsibleSearchOptions(
                          searchResult: searchResult.value,
                          recentSearches: provider.searches,
                          showRecent: searchController.text.length < 2,
                        ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
