
import 'package:concepta_test/state/recent_search_provider.dart';
import 'package:concepta_test/ui/widgets/collapsible_search_options.dart';
import 'package:concepta_test/utils/search_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollapsibleSearchBar extends StatefulWidget {
  const CollapsibleSearchBar({super.key, this.isOpen = false});

  final bool isOpen;

  @override
  State<CollapsibleSearchBar> createState() => CollapsibleSearchBarState();
}

class CollapsibleSearchBarState extends State<CollapsibleSearchBar> {
  FocusNode formFocusNode = FocusNode();

  ValueNotifier<bool> openNotifier = ValueNotifier(false);
  ValueNotifier<bool> loadNotifier = ValueNotifier(false);
  ValueNotifier<List<String>> searchResult = ValueNotifier([]);

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    openNotifier.value = widget.isOpen;

    formFocusNode.addListener(() {
      if (!formFocusNode.hasFocus) openNotifier.value = false;
    });
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
    return ValueListenableBuilder(
      valueListenable: openNotifier,
      builder: (context, isOpen, _) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            height: 64,
            width: isOpen ? 300 : 64,
            padding: EdgeInsets.symmetric(horizontal: isOpen ? 20 : 0),
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 400),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.5,
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(32),
            ),
            child: isOpen
                ? TextFormField(
                    controller: searchController,
                    focusNode: formFocusNode..requestFocus(),
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
                    onPressed: () => openNotifier.value = true,
                  ),
          ),
          if (isOpen)
            Card(
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
                      : Consumer<RecentSearchProvider>(
                        builder: (context, provider, _) => CollapsibleSearchOptions(
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

