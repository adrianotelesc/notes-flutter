import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:postnote/ui/theming.dart';
import 'package:postnote/ui/routing.dart';

class PostnoteApp extends StatelessWidget {
  const PostnoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Postnote',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: PostnoteTheming.light,
      darkTheme: PostnoteTheming.dark,
      routerConfig: PostnoteRouting.routerConfig,
    );
  }
}
