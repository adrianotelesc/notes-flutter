import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:postnote/ui/page/adaptive_notes/adaptive_notes_page.dart';
import 'package:postnote/ui/page/home/home_page.dart';

class PostnoteRouting {
  PostnoteRouting._();

  static RouterConfig<Object>? routerConfig(
    GlobalKey<NavigatorState> navigatorKey,
  ) {
    return GoRouter(
      navigatorKey: navigatorKey,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomePage(key: state.pageKey),
          routes: [
            GoRoute(
              path: ':code',
              builder: (context, state) => AdaptiveNotesPage(
                code: state.pathParameters['code'] ?? '',
              ),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) {
                    return AdaptiveNotesPage(
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
