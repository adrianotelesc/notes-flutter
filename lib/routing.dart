import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:postnote/ui/screen/home/home_screen.dart';
import 'package:postnote/ui/screen/note_details/note_details_screen.dart';
import 'package:postnote/ui/screen/note_list_detail_scaffold.dart';
import 'package:postnote/ui/screen/notes/notes_screen.dart';

abstract class PostnoteRouting {
  static RouterConfig<Object> routerConfig(
    GlobalKey<NavigatorState> rootNavigatorKey,
    GlobalKey<NavigatorState> shellNavigatorKey,
  ) {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomeScreen(key: state.pageKey),
          routes: [
            ShellRoute(
              parentNavigatorKey: rootNavigatorKey,
              navigatorKey: shellNavigatorKey,
              builder: (context, state, child) {
                final code = state.pathParameters['code'] ?? '';
                final noteId = state.pathParameters['id'];

                return NoteListDetailScaffold(
                  key: state.pageKey,
                  code: code,
                  noteId: noteId,
                  list: NotesScreen(code: code),
                  detail: child,
                );
              },
              routes: [
                GoRoute(
                  parentNavigatorKey: shellNavigatorKey,
                  path: ':code',
                  builder: (context, state) {
                    return Container(
                      key: state.pageKey,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    );
                  },
                ),
                GoRoute(
                  parentNavigatorKey: shellNavigatorKey,
                  path: ':code/:id',
                  builder: (context, state) {
                    return NoteDetailsScreen(
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
