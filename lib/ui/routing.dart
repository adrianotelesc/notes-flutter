import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:postnote/ui/pages/home_page.dart';
import 'package:postnote/ui/pages/note_detail/note_detail_page.dart';
import 'package:postnote/ui/pages/note_list/note_list_page.dart';
import 'package:postnote/ui/utils/screen_utils.dart';

abstract class PostnoteRouting {
  static const _transitionDuration = Duration(milliseconds: 150);
  static const _dialogWidth = 800.0;
  static const _dialogHorizontalInsetPadding = 24.0;
  static const _dialogCornerRadius = 16.0;

  static RouterConfig<Object> get routerConfig {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (_, state) {
            return MaterialPage<void>(
              key: state.pageKey,
              child: const HomePage(),
            );
          },
          routes: [
            GoRoute(
              path: ':boardId',
              pageBuilder: (_, state) {
                final boardId = state.pathParameters['boardId'] ?? '';

                return MaterialPage<void>(
                  key: state.pageKey,
                  child: NoteListPage(boardId: boardId),
                );
              },
              routes: [
                GoRoute(
                  path: ':noteId',
                  pageBuilder: (context, state) {
                    final boardId = state.pathParameters['boardId'] ?? '';
                    final noteId = state.pathParameters['noteId'];

                    final isSmallScreen = ScreenUtils.isSmallScreen(context);

                    return CustomTransitionPage<void>(
                      key: state.pageKey,
                      fullscreenDialog: isSmallScreen,
                      child: isSmallScreen
                          ? Dialog.fullscreen(
                              insetAnimationDuration: _transitionDuration,
                              child: NoteDetailPage(
                                boardId: boardId,
                                noteId: noteId,
                              ),
                            )
                          : Dialog(
                              clipBehavior: Clip.antiAlias,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(_dialogCornerRadius),
                                ),
                              ),
                              insetPadding: const EdgeInsets.symmetric(
                                horizontal: _dialogHorizontalInsetPadding,
                                vertical: kToolbarHeight,
                              ),
                              child: SizedBox(
                                width: _dialogWidth,
                                child: NoteDetailPage(
                                  boardId: boardId,
                                  noteId: noteId,
                                ),
                              ),
                            ),
                      transitionDuration: _transitionDuration,
                      reverseTransitionDuration: _transitionDuration,
                      barrierColor: Colors.black54,
                      barrierDismissible: true,
                      opaque: false,
                      transitionsBuilder: (context, animation, _, child) {
                        return Transform.scale(
                          scale: animation.value,
                          child: Opacity(
                            opacity: animation.value,
                            child: child,
                          ),
                        );
                      },
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
