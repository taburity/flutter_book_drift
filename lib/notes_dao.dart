import 'package:drift/drift.dart';
import 'notes_database.dart';
import 'notes.dart';

part 'notes_dao.g.dart';

@DriftAccessor(tables: [Notes])
class NotesDao extends DatabaseAccessor<NotesDatabase> with _$NotesDaoMixin {
  NotesDao(super.db);

  Future<List<Note>> getAllNotes() => select(notes).get();

  Future<Note?> getNoteById(int id) =>
      (select(notes)
        ..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<int> insertNote(NotesCompanion note) =>
      into(notes).insert(note);

  Future<bool> updateNote(Note note) =>
      update(notes).replace(note);

  Future<int> deleteNote(Note note) =>
      delete(notes).delete(note);
}