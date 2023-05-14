class Notes {
  String? id;
  String priority;
  String title;
  String description;

  Notes(
      {this.id,
      required this.priority,
      required this.title,
      required this.description});

  dynamic toJson(Notes note) {
    return {
      "id": note.id ?? '',
      "priority": note.priority,
      "title": note.title,
      "description": note.description,
    };
  }
}
