import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:postnote/ui/pages/home_page.dart';
import 'package:postnote/ui/pages/note_detail/note_detail_page.dart';
import 'package:postnote/ui/pages/note_list/note_list_page.dart';
import 'package:postnote/ui/utils/screen_utils.dart';

abstract class PostnoteRouting {
  static const _dialogMaxSize = 600.0;
  static const _dialogMinHeight = 182.0;
  static const _dialogHorizontalInsetPadding = 24.0;
  static const _dialogCornerRadius = 16.0;

  static const _transitionDuration = Duration(milliseconds: 200);

  static RouterConfig<Object> routerConfig = GoRouter(
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
                  final isSmallScreen = ScreenUtils.isSmallScreen(context);

                  final boardId = state.pathParameters['boardId'] ?? '';
                  final noteId = state.pathParameters['noteId'];

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
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: _dialogMaxSize,
                                maxHeight: _dialogMaxSize,
                                minHeight: _dialogMinHeight,
                              ),
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
                      return FadeScaleTransition(
                        animation: animation,
                        child: child,
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
