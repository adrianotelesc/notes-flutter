import 'package:postnote/ui/page/home/home_page.dart';
import 'package:postnote/ui/page/two_panel_notes_page.dart';
import 'package:postnote/web_stub_plugins.dart'
    if (dart.library.html) 'package:postnote/web_plugins.dart'
    if (dart.library.io) 'package:postnote/web_stub_plugins.dart' as plugins;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:postnote/data/repository/note_repository.dart';
import 'package:postnote/data/repository/note_repository_impl.dart';
import 'package:postnote/ui/page/note_details/note_details_cubit.dart';
import 'package:postnote/ui/page/notes/notes_cubit.dart';

void main() {
  plugins.setUpPlugins();
  setUpDependencies();
  runApp(PostnoteApp());
}

void setUpDependencies() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<NoteRepository>(NoteRepositoryImpl());
  getIt.registerFactory(() => NotesCubit());
  getIt.registerFactory(() => NoteDetailsCubit());
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
        useMaterial3: true,
        brightness: Brightness.light,
        popupMenuTheme: const PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(minimumSize: const Size(0, 56)),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(minimumSize: const Size(0, 56)),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 20),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        popupMenuTheme: const PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(minimumSize: const Size(0, 56)),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(minimumSize: const Size(0, 56)),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 20),
        ),
      ),
      themeMode: ThemeMode.system,
      routerConfig: GoRouter(
        navigatorKey: _navigationKey,
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => HomePage(key: state.pageKey),
            routes: [
              GoRoute(
                path: ':code',
                builder: (context, state) => TwoPanelNotesPage(
                  code: state.pathParameters['code'] ?? '',
                ),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) {
                      return TwoPanelNotesPage(
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
      ),
    );
  }
}
