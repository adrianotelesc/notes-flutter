import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:postnote/ui/pages/home_page.dart';
import 'package:postnote/ui/pages/note_detail/note_detail_page.dart';
import 'package:postnote/ui/pages/note_list/note_list_page.dart';

abstract class PostnoteRouting {
  static RouterConfig<Object> get routerConfig {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => HomePage(key: state.pageKey),
          routes: [
            GoRoute(
              path: ':boardId',
              pageBuilder: (context, state) {
                final boardId = state.pathParameters['boardId'] ?? '';

                return NoteListPage(key: state.pageKey, boardId: boardId);
              },
              routes: [
                GoRoute(
                  path: ':noteId',
                  pageBuilder: (context, state) {
                    final boardId = state.pathParameters['boardId'] ?? '';
                    final noteId = state.pathParameters['noteId'];

                    return NoteDetailPage(
                      key: state.pageKey,
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
