import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:postnote/ui/screen/adaptive_notes/adaptive_notes_screen.dart';
import 'package:postnote/ui/screen/home/home_screen.dart';

class PostnoteRouting {
  PostnoteRouting._();

  static RouterConfig<Object> routerConfig(
    GlobalKey<NavigatorState> navigatorKey,
  ) {
    return GoRouter(
      navigatorKey: navigatorKey,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomeScreen(key: state.pageKey),
          routes: [
            GoRoute(
              path: ':code',
              builder: (context, state) => AdaptiveNotesScreen(
                code: state.pathParameters['code'] ?? '',
              ),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) {
                    return AdaptiveNotesScreen(
                      key: UniqueKey(),
                      code: state.pathParameters['code'] ?? '',
                      noteId: state.pathParameters['id'],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
