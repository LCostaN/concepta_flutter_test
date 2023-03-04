import 'package:concepta_test/state/recent_search_provider.dart';
import 'package:concepta_test/ui/result/result_view.dart';
import 'package:concepta_test/utils/local_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollapsibleSearchItem extends StatefulWidget {
  const CollapsibleSearchItem({super.key, required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  State<CollapsibleSearchItem> createState() => _CollapsibleSearchItemState();
}

class _CollapsibleSearchItemState extends State<CollapsibleSearchItem> {
  ValueNotifier<bool> hoverNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ValueListenableBuilder(
        valueListenable: hoverNotifier,
        builder: (context, isHovering, _) {
          return AnimatedContainer(
            height: 36,
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.fromLTRB(28, 8, 28, 8),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: isHovering ? Theme.of(context).primaryColor : null,
            ),
            child: Text(
              widget.text,
              style: TextStyle(color: isHovering ? Colors.black : null),
            ),
          );
        },
      ),
      onHover: (hover) => hoverNotifier.value = hover,
      onTap: () => goToDetails(widget.text),
    );
  }

  void goToDetails(String text) async {
    LocalUtils()
        .addSearch(text)
        .then((_) => context.read<RecentSearchProvider>().refresh());
        
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ResultView(package: text)),
    );
  }
}
