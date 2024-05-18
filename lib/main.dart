import 'package:postnote/ui/page/home/home_page.dart';
import 'package:postnote/web_stub_plugins.dart'
    if (dart.library.html) 'package:postnote/web_plugins.dart'
    if (dart.library.io) 'package:postnote/web_stub_plugins.dart' as plugins;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:postnote/data/repository/note_repository.dart';
import 'package:postnote/data/repository/note_repository_impl.dart';
import 'package:postnote/ui/page/note_editor/note_editor_cubit.dart';
import 'package:postnote/ui/page/note_editor/note_editor_page.dart';
import 'package:postnote/ui/page/notes/notes_cubit.dart';
import 'package:postnote/ui/page/notes/notes_page.dart';

void main() {
  plugins.setUpPlugins();
  setUpDependencies();
  runApp(PostnoteApp());
}

void setUpDependencies() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<NoteRepository>(NoteRepositoryImpl());
  getIt.registerFactory(() => NotesCubit());
  getIt.registerFactory(() => NoteEditorCubit());
}

class PostnoteApp extends StatelessWidget {
  PostnoteApp({super.key});

  final _navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Postnote',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        popupMenuTheme: const PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        popupMenuTheme: const PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      routerConfig: GoRouter(
        navigatorKey: _navigationKey,
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => HomePage(key: state.pageKey),
          ),
          GoRoute(
            path: '/:topic',
            builder: (context, state) => NotesPage(
              key: state.pageKey,
              topic: state.pathParameters['topic'] ?? '',
            ),
            routes: [
              GoRoute(
                path: ':id',
                pageBuilder: (context, state) {
                  return NoteEditorPage(
                    key: state.pageKey,
                    topic: state.pathParameters['topic'] ?? '',
                    noteId: state.pathParameters['id'],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
