import 'package:flutter_web_plugins/flutter_web_plugins.dart';
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
  usePathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;
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
        initialLocation: '/notes',
        navigatorKey: _navigationKey,
        routes: [
          GoRoute(
            path: '/notes',
            builder: (context, state) => const NotesPage(),
          ),
          GoRoute(
            path: '/notes/new',
            builder: (context, state) => const NoteEditorPage(),
          ),
          GoRoute(
            path: '/notes/:id',
            builder: (context, state) => NoteEditorPage(
              noteId: state.pathParameters['id'] ?? '',
            ),
          ),
        ],
      ),
    );
  }
}
