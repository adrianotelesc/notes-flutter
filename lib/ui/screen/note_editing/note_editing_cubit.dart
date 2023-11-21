import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/data/repository/note_repository.dart';
import 'package:notes/ui/screen/note_editing/note_editing_ui_state.dart';

class NoteEditingCubit extends Cubit<NoteEditingUiState> {
  NoteRepository noteRepo;

  NoteEditingCubit({required this.noteRepo})
      : super(const NoteEditingUiState());
}
