import 'package:get_it/get_it.dart';

import 'package:postnote/data/repositories/note_repository.dart';
import 'package:postnote/data/repositories/note_repository_impl.dart';
import 'package:postnote/ui/pages/note_detail/note_detail_cubit.dart';
import 'package:postnote/ui/pages/note_list/note_list_cubit.dart';

void setUpDependencies() {
  GetIt.I.registerSingleton<NoteRepository>(NoteRepositoryImpl());

  GetIt.I.registerFactoryParam<NoteListCubit, String, void>(
    (boardId, _) => NoteListCubit(
      boardId,
      GetIt.I<NoteRepository>(),
    ),
  );
  GetIt.I.registerFactoryParam<NoteDetailCubit, String, void>(
    (boardId, _) => NoteDetailCubit(
      boardId,
      GetIt.I<NoteRepository>(),
    ),
  );
}
