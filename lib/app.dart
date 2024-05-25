import 'package:flutter/material.dart';

import 'package:postnote/theming.dart';
import 'package:postnote/routing.dart';

class PostnoteApp extends StatelessWidget {
  PostnoteApp({super.key});

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Postnote',
      debugShowCheckedModeBanner: false,
      theme: PostnoteTheming.light,
      darkTheme: PostnoteTheming.dark,
      routerConfig: PostnoteRouting.routerConfig(_navigatorKey),
    );
  }
}
