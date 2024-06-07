import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:postnote/ui/screens/home_screen.dart';
import 'package:postnote/ui/screens/note_detail/note_detail_screen.dart';
import 'package:postnote/ui/screens/note_list_detail_screen.dart';
import 'package:postnote/ui/screens/note_list/note_list_screen.dart';

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
                final collectionId = state.pathParameters['collectionId'] ?? '';
                final noteId = state.pathParameters['noteId'];

                return NoteListDetailScreen(
                  key: state.pageKey,
                  collectionId: collectionId,
                  noteId: noteId,
                  list: NoteListScreen(collectionId: collectionId),
                  detail: child,
                );
              },
              routes: [
                GoRoute(
                  path: ':collectionId',
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
                  path: ':collectionId/:noteId',
                  builder: (context, state) {
                    final collectionId =
                        state.pathParameters['collectionId'] ?? '';
                    final noteId = state.pathParameters['noteId'];

                    return NoteDetailScreen(
                      key: UniqueKey(),
                      collectionId: collectionId,
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
