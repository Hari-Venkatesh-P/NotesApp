const String columnId = '_id';
const String columnTitle = 'title';
const String columnDescription = 'description';
const String columnPriority = 'priority';

class NotesEntity {
  int id;
  final String title;
  final String description;
  final String priority;

  NotesEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.priority});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnTitle: title,
      columnDescription: description,
      columnPriority: priority,
    };
    return map;
  }

  static NotesEntity emptyNote() {
    return NotesEntity(id: -1, title: '', description: '', priority: '');
  }

  static NotesEntity fromMap(Map<dynamic, dynamic> map) {
    final id = map[columnId];
    final title = map[columnTitle];
    final description = map[columnDescription];
    final priority = map[columnPriority];
    try {
      return NotesEntity(
          id: id, title: title, description: description, priority: priority);
    } catch (e) {
      return NotesEntity(id: -1, title: '', description: '', priority: '');
    }
  }
}
