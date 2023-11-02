// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:flutter_notes_app/data/models/response/notes_reponse_model.dart';

import '../data/datasources/notes_remote_datasources.dart';
import '../pages/detail_note_page.dart';
import '../pages/home_page.dart';

class NoteContainer extends StatefulWidget {
  final Note noteData;
  final Color noteColor;
  final String title;
  final String date;

  const NoteContainer({
    Key? key,
    required this.noteData,
    required this.noteColor,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  State<NoteContainer> createState() => _NoteContainerState();
}

class _NoteContainerState extends State<NoteContainer> {
  bool isLongPressing = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        isLongPressing
            ? {
                await showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(30),
                      child: Wrap(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                const Text(
                                  'Confirm',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Are you sure want to delete this note?',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.grey[600],
                                      ),
                                      child: const Text('No'),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await NotesRemoteDatasource()
                                            .deleteNote(
                                          widget.noteData.id.toString(),
                                        );
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage(),
                                            ),
                                            (route) => false);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Succesfully delete a note',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            backgroundColor: Colors.white,
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.blueGrey,
                                      ),
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )
              }
            : // pass data
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailNotePage(
                    noteData: widget.noteData,
                  ),
                ),
              );
      },
      onLongPress: () {
        setState(() {
          isLongPressing = !isLongPressing;
        });
      },
      child: isLongPressing
          ? Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 45,
                vertical: 30,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    size: 45,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.noteColor,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 45,
                vertical: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.date,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
