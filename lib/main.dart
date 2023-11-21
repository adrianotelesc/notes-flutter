import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/data/repository/note_repository.dart';
import 'package:notes/data/repository/note_repository_impl.dart';
import 'package:notes/ui/screen/note_editing/note_editing_screen.dart';
import 'package:notes/ui/screen/notes/notes_screen.dart';

final getIt = GetIt.instance;

void main() {
  setup();
  runApp(const MyApp());
}

void setup() {
  getIt.registerSingleton<NoteRepository>(NoteRepositoryImpl());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
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
        '/notes': (_) => const NotesScreen(),
        '/note-editing': (_) => const NoteEditingScreen(),
      },
      home: const NotesScreen(),
    );
  }
}
