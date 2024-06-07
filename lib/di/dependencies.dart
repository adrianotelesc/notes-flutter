import 'package:get_it/get_it.dart';

import 'package:postnote/data/repositories/note_repository.dart';
import 'package:postnote/data/repositories/note_repository_impl.dart';
import 'package:postnote/ui/screens/note_detail/note_detail_cubit.dart';
import 'package:postnote/ui/screens/note_list/note_list_cubit.dart';

void setUpDependencies() {
  GetIt.I.registerSingleton<NoteRepository>(NoteRepositoryImpl());

  GetIt.I.registerFactoryParam<NoteListCubit, String, void>(
    (collectionId, _) => NoteListCubit(
      collectionId,
      GetIt.I<NoteRepository>(),
    ),
  );
  GetIt.I.registerFactoryParam<NoteDetailCubit, String, void>(
    (collectionId, _) => NoteDetailCubit(
      collectionId,
      GetIt.I<NoteRepository>(),
    ),
  );
}
