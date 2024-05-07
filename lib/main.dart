import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:postnote/data/repository/note_repository.dart';
import 'package:postnote/data/repository/note_repository_impl.dart';
import 'package:postnote/ui/page/note_editor/note_editor_page.dart';
import 'package:postnote/ui/page/notes/notes_page.dart';

final getIt = GetIt.instance;

void main() {
  setup();
  runApp(const PostnoteApp());
}

void setup() {
  getIt.registerSingleton<NoteRepository>(NoteRepositoryImpl());
}

class PostnoteApp extends StatelessWidget {
  const PostnoteApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      routes: {
        '/notes': (_) => const NotesPage(),
        '/note-editor': (_) => const NoteEditorPage(),
      },
      home: const NotesPage(),
    );
  }
}
