import 'package:sqflite/sqflite.dart';
import 'package:todo_app/entity/notes_entity.dart';

const String tableNotes = 'notes';
const String columnId = '_id';
const String columnTitle = 'title';
const String columnDescription = 'description';
const String columnPriority = 'priority';

class DataProvider {
  Database? db;

  Future<bool> databaseExists(String path) =>
      databaseFactory.databaseExists(path);

  Future open(String path) async {
    var databasesPath = await getDatabasesPath();
    var path = '$databasesPath path';
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableNotes ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnDescription text not null,
  $columnPriority text not null)
''');
    });
  }

  Future<NotesEntity> insert(NotesEntity notes) async {
    final db = this.db;
    if (db != null) {
      notes.id = await db.insert(tableNotes, notes.toMap());
      return notes;
    }
    return NotesEntity.emptyNote();
  }

  Future<List<NotesEntity>> getNotes() async {
    final db = this.db;
    if (db != null) {
      List<NotesEntity> notesList = [];
      List<Map> maps = await db.query(tableNotes,
          columns: [columnId, columnTitle, columnDescription, columnPriority]);
      for (var element in maps) {
        notesList.add(NotesEntity.fromMap(element));
      }
      return notesList;
    }
    return [];
  }

  Future<int> deleteNote(int id) async {
    final db = this.db;
    if (db != null) {
      var a =
          await db.delete(tableNotes, where: '$columnId = ?', whereArgs: [id]);
      return a;
    }
    return 0;
  }

  Future<int> updateNote(NotesEntity notesEntity) async {
    final db = this.db;
    if (db != null) {
      return await db.update(tableNotes, notesEntity.toMap(),
          where: '$columnId = ?', whereArgs: [notesEntity.id]);
    }
    return 0;
  }

  Future close() async {
    final db = this.db;
    if (db != null) {
      db.close();
    }
  }
}
