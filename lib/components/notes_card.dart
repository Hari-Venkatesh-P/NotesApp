import 'package:flutter/material.dart';
import 'package:todo_app/model/notes.dart';

class NotesCard extends StatefulWidget {
  final Notes notes;

  final Function onEditNote;

  final Function onDeleteNote;

  const NotesCard(
      {Key? key,
      required this.notes,
      required this.onEditNote,
      required this.onDeleteNote})
      : super(key: key);

  @override
  State<NotesCard> createState() => _NotesCardState();
}

class _NotesCardState extends State<NotesCard> {
  bool isDragged = false;

  Widget renderOtherOptionsSections() {
    if (isDragged) {
      return Container(
        height: 200,
        width: 68,
        color: Colors.grey,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => widget.onEditNote(widget.notes),
              child: const Icon(
                Icons.edit,
                color: Colors.black,
                size: 24.0,
                semanticLabel: 'Edit',
              ),
            ),
            GestureDetector(
              onTap: () => widget.onDeleteNote(widget.notes.id),
              child: const Icon(
                Icons.delete,
                color: Colors.black,
                size: 24.0,
                semanticLabel: 'Delete',
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }

  BoxShadow getPriorityStyle() {
    const offset = Offset(
      3.0,
      3.0,
    );
    switch (widget.notes.priority) {
      case "Low":
        return const BoxShadow(
          color: Color(0xffaed3ac),
          blurRadius: 8.0,
          spreadRadius: 8.0,
          offset: offset,
        );
      case "High":
        return const BoxShadow(
            color: Color(0xffe5a1a1),
            blurRadius: 8.0,
            spreadRadius: 8.0,
            offset: offset);
      default:
        return const BoxShadow(
          color: Color(0xBADCC83F),
          blurRadius: 8.0,
          spreadRadius: 8.0,
          offset: offset,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          setState(() {
            isDragged = false;
          });
        } else if (details.velocity.pixelsPerSecond.dx < 0) {
          setState(() {
            isDragged = true;
          });
        }
      },
      child: Container(
          height: 140,
          width: 370,
          decoration: BoxDecoration(
            color: Color(0xFFffffff),
            boxShadow: [getPriorityStyle()],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: isDragged ? 303 : 368,
                // width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: isDragged ? 250 : 300,
                      margin: const EdgeInsets.only(top: 3, bottom: 3),
                      child: Text(
                        widget.notes.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 22.0),
                      ),
                    ),
                    Container(
                      width: isDragged ? 250 : 300,
                      margin: const EdgeInsets.only(top: 3, bottom: 3),
                      child: Text(
                        widget.notes.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
              renderOtherOptionsSections(),
            ],
          )),
    );
  }
}
