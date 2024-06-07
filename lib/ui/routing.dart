import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:postnote/ui/screens/home_screen.dart';
import 'package:postnote/ui/screens/note_detail/note_detail_screen.dart';
import 'package:postnote/ui/screens/note_list/note_list_screen.dart';

abstract class PostnoteRouting {
  static RouterConfig<Object> get routerConfig {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomeScreen(key: state.pageKey),
          routes: [
            GoRoute(
              path: ':boardId',
              builder: (context, state) {
                final boardId = state.pathParameters['boardId'] ?? '';

                return NoteListScreen(boardId: boardId);
              },
              routes: [
                GoRoute(
                  path: ':noteId',
                  builder: (context, state) {
                    final boardId = state.pathParameters['boardId'] ?? '';
                    final noteId = state.pathParameters['noteId'];

                    return NoteDetailScreen(
                      boardId: boardId,
                      noteId: noteId,
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
