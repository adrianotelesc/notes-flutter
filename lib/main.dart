import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:postnote/data/repository/note_repository.dart';
import 'package:postnote/data/repository/note_repository_impl.dart';
import 'package:postnote/ui/page/note_editor/note_editor_cubit.dart';
import 'package:postnote/ui/page/note_editor/note_editor_page.dart';
import 'package:postnote/ui/page/notes/notes_cubit.dart';
import 'package:postnote/ui/page/notes/notes_page.dart';

void main() {
  setUpDependencies();
  runApp(const PostnoteApp());
}

void setUpDependencies() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<NoteRepository>(NoteRepositoryImpl());
  getIt.registerFactory(() => NotesCubit());
  getIt.registerFactoryParam<NoteEditorCubit, String?, void>((noteId, _) {
    return NoteEditorCubit(noteId: noteId);
  });
}

class PostnoteApp extends StatelessWidget {
  const PostnoteApp({super.key});

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
        '/notes': (_) => NotesPage(),
        '/note-editor': (_) => const NoteEditorPage(),
      },
      home: NotesPage(),
    );
  }
}
