import 'package:concepta_test/state/recent_search_provider.dart';
import 'package:concepta_test/ui/app/app_theme.dart';
import 'package:concepta_test/ui/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchProvider(),
      builder: (context, _) => MaterialApp(
        title: 'Concepta Flutter Test',
        theme: theme,
        home: const SearchView(),
      ),
    );
  }
}
