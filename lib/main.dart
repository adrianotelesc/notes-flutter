import 'package:postnote/web_stub_plugins.dart'
    if (dart.html) 'package:postnote/web_plugins.dart'
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
import 'package:postnote/ui/util/dialog_page.dart';

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
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      routerConfig: GoRouter(
        navigatorKey: _navigationKey,
        initialLocation: '/notes',
        routes: [
          GoRoute(
            path: '/notes',
            builder: (context, state) => const NotesPage(),
            routes: [
              GoRoute(
                path: 'new',
                pageBuilder: (context, state) {
                  return DialogPage(
                    builder: (_) => const NoteEditorPage(),
                  );
                },
              ),
              GoRoute(
                path: ':id',
                pageBuilder: (context, state) {
                  return DialogPage(
                    builder: (_) {
                      return NoteEditorPage(
                        noteId: state.pathParameters['id'] ?? '',
                      );
                    },
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
