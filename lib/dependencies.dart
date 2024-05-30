import 'package:get_it/get_it.dart';

import 'package:postnote/data/repositories/note_repository.dart';
import 'package:postnote/data/repositories/note_repository_impl.dart';
import 'package:postnote/ui/views/note_detail/note_detail_cubit.dart';
import 'package:postnote/ui/views/note_list/note_list_cubit.dart';

void setUpDependencies() {
  GetIt.I.registerSingleton<NoteRepository>(NoteRepositoryImpl());

  GetIt.I.registerFactory(() => NotesCubit(GetIt.I<NoteRepository>()));
  GetIt.I.registerFactory(() => NoteDetailsCubit(GetIt.I<NoteRepository>()));
}
