import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:postnote/ui/screens/home_screen.dart';
import 'package:postnote/ui/views/note_detail/note_detail_view.dart';
import 'package:postnote/ui/screens/note_list_detail_screen.dart';
import 'package:postnote/ui/views/note_list/note_list_view.dart';

abstract class PostnoteRouting {
  static RouterConfig<Object> get routerConfig {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomeScreen(key: state.pageKey),
          routes: [
            ShellRoute(
              builder: (context, state, child) {
                final code = state.pathParameters['code'] ?? '';
                final noteId = state.pathParameters['id'];

                return NoteListDetailScreen(
                  key: state.pageKey,
                  code: code,
                  noteId: noteId,
                  list: NoteListView(code: code),
                  detail: child,
                );
              },
              routes: [
                GoRoute(
                  path: ':code',
                  builder: (context, state) {
                    return Container(
                      key: state.pageKey,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Center(
                        child: Text(
                          'Crie ou abra uma nota',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    );
                  },
                ),
                GoRoute(
                  path: ':code/:id',
                  builder: (context, state) {
                    final code = state.pathParameters['code'] ?? '';
                    final noteId = state.pathParameters['id'];

                    return NoteDetailView(
                      key: UniqueKey(),
                      code: code,
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
