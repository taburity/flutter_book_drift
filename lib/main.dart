import 'package:flutter/material.dart';
import 'notes_database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<List<Note>> _loadNotes() async {
    final database = NotesDatabase();
    final dao = database.notesDao;

    await dao.insertNote(
      NotesCompanion.insert(
        title: 'Exemplo de Nota',
        content: 'Este é o conteúdo da nota.',
      ),
    );
    return dao.getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<List<Note>>(
        future: _loadNotes(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final notes = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Drift Example'),
            ),
            body: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (_, index) {

                final note = notes[index];

                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                );
              },
            ),
          );
        },
      ),
    );
  }
}