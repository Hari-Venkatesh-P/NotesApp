import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_app/Utils/constants.dart';
import 'package:todo_app/components/notes_card.dart';
import 'package:todo_app/model/notes.dart';
import 'package:todo_app/molecules/custom_button.dart';
import 'package:todo_app/molecules/custom_radio_button.dart';
import 'package:todo_app/molecules/custom_text_input.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Notes> notesList = [];

  final titleTextController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleTextController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Map<String, Color> getStyles() {
    var styles = <String, Color>{};
    styles['selectedBackgroundColor'] = Colors.grey;
    return styles;
  }

  void showAddNotesBottomSheet(isEdit, onButtonPress, {Notes? note}) {
    String curPriority = isEdit ? note!.priority : low;
    if (isEdit && note != null) {
      titleTextController.text = note.title;
      descriptionController.text = note.description;
    }
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder:
              (BuildContext stateBuilderContext, StateSetter setState) {
            return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      child: CustomTextInput(titleTextController.text, 'Title',
                          'Title', titleTextController, (val) => {}),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      child: CustomTextInput(
                          descriptionController.text,
                          'Notes description',
                          'Description',
                          descriptionController,
                          (val) => {},
                          isTextAreaField: true),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      child: CustomRadioButton(
                          curPriority,
                          note_priority_options,
                          getStyles(),
                          (val) => {
                                setState(() {
                                  curPriority = val;
                                })
                              }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      child: CustomButton(
                          isEdit ? 'Edit Note' : 'Add Note',
                          (val) => {
                                if (titleTextController.text.isNotEmpty &&
                                    descriptionController.text.isNotEmpty)
                                  {
                                    onButtonPress(Notes(
                                        id: isEdit
                                            ? note!.id
                                            : (Random().nextDouble() * 256)
                                                .toString(),
                                        priority: curPriority,
                                        title: titleTextController.text,
                                        description:
                                            descriptionController.text)),
                                    titleTextController.text = '',
                                    descriptionController.text = '',
                                    Navigator.pop(context),
                                  }
                                else
                                  {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Provide valid data'),
                                    ))
                                  }
                              }),
                    ),
                  ],
                )));
          });
        });
  }

  void onNativeBackButtonPressed() {
      // print('on back');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          onNativeBackButtonPressed();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
          ),
          body: ListView.builder(
              itemCount: notesList.isNotEmpty ? notesList.length : 0,
              itemBuilder: (BuildContext context, int index) {
                final note = notesList[index];
                return Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20),
                    child: NotesCard(
                        notes: note,
                        onEditNote: (Notes note) => {
                              showAddNotesBottomSheet(true, (Notes editedNote) {
                                setState(() {
                                  notesList = notesList.map((curNote) {
                                    if (note.id == curNote.id) {
                                      return editedNote;
                                    } else {
                                      return curNote;
                                    }
                                  }).toList();
                                });
                              }, note: note)
                            },
                        onDeleteNote: (id) => {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text('Are you sure to delete'),
                                action: SnackBarAction(
                                  label: 'Yes',
                                  onPressed: () {
                                    setState(() {
                                      notesList = notesList
                                          .where((curNote) => curNote.id != id)
                                          .toList();
                                    });
                                    // Some code to undo the change.
                                  },
                                ),
                              ))
                            }));
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () => {
              showAddNotesBottomSheet(false, (Notes notes) {
                notesList.add(notes);
                setState(() {
                  notesList = notesList;
                });
              }),
            },
            tooltip: 'Add Note',
            child: const Icon(Icons.add),
          ),
        ));
  }
}
