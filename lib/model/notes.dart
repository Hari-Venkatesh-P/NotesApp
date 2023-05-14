import 'package:todo_app/entity/notes_entity.dart';

class Notes {
  int? id;
  String priority;
  String title;
  String description;

  Notes(
      {this.id,
      required this.priority,
      required this.title,
      required this.description});

  static NotesEntity toEntity(Notes notes) {
    return NotesEntity(
        id: notes.id ?? -1,
        title: notes.title,
        description: notes.description,
        priority: notes.priority);
  }

  static Notes fromEntity(NotesEntity entity) {
    return Notes(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        priority: entity.priority);
  }
}
