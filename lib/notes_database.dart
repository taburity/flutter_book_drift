import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'notes.dart';
import 'notes_dao.dart';

part 'notes_database.g.dart';

@DriftDatabase(
  tables: [Notes],
  daos: [NotesDao],
)
class NotesDatabase extends _$NotesDatabase {
  NotesDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(
      p.join(dbFolder.path, 'notes.db'),
    );
    return NativeDatabase.createInBackground(file);
  });
}