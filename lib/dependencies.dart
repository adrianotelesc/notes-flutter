import 'package:get_it/get_it.dart';

import 'package:postnote/data/repository/note_repository.dart';
import 'package:postnote/data/repository/note_repository_impl.dart';
import 'package:postnote/ui/page/note_details/note_details_cubit.dart';
import 'package:postnote/ui/page/notes/notes_cubit.dart';

void setUpDependencies() {
  GetIt.I.registerSingleton<NoteRepository>(NoteRepositoryImpl());

  GetIt.I.registerFactory(() => NotesCubit(GetIt.I<NoteRepository>()));
  GetIt.I.registerFactory(() => NoteDetailsCubit(GetIt.I<NoteRepository>()));
}
