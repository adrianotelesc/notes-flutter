import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:postnote/ui/theming.dart';
import 'package:postnote/ui/routing.dart';

class PostnoteApp extends StatelessWidget {
  PostnoteApp({super.key});

  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Postnote',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: PostnoteTheming.light,
      darkTheme: PostnoteTheming.dark,
      routerConfig: PostnoteRouting.routerConfig(
        _rootNavigatorKey,
        _shellNavigatorKey,
      ),
    );
  }
}
