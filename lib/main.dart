import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/data/repository/note_repository_impl.dart';
import 'package:notes/ui/screen/notes/notes_cubit.dart';
import 'package:notes/ui/screen/notes/notes_screen.dart';

void main() {
  runApp(const MyApp());
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
      home: BlocProvider(
        create: (_) => NotesCubit(noteRepo: NoteRepositoryImpl()),
        child: const NotesScreen(),
      ),
    );
  }
}
