import 'package:flutter/material.dart';
import 'package:flutter_notes_app/custom_func/func.dart';
import 'package:flutter_notes_app/data/datasources/notes_remote_datasources.dart';
import 'package:flutter_notes_app/pages/new_note_page.dart';
import 'package:flutter_notes_app/widget/note_container.dart';
import 'package:flutter_notes_app/widget/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List notes = [];
  late DateFormat dateFormat;

  Future<void> getNotes() async {
    setState(() {
      isLoading = true;
    });
    //  await Future.delayed(const Duration(seconds: 3));
    final model = await NotesRemoteDatasource().getNotes();
    notes = model.data;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getNotes();
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMEd('id');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff252525),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 47, right: 25, left: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Notes',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 43,
                    ),
                  ),
                  const SizedBox(height: 37),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isLoading
                          ? const ShimmerNotes()
                          : (notes.isEmpty)
                              ? Column(
                                  children: [
                                    Image.asset(
                                      'assets/blank.png',
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    const Text(
                                      'Create your first note!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    notes.length,
                                    (index) {
                                      var dateCreated = notes[index].createdAt;
                                      var date = dateFormat
                                          .format(dateCreated)
                                          .toString();
                                      var title = notes[index].title;
                                      var noteData = notes[index];
                                      var noteColor =
                                          CustomFunc.hexStringToColor(
                                              notes[index].labelColor);
                                      return Column(
                                        children: [
                                          NoteContainer(
                                            noteData: noteData,
                                            noteColor: noteColor,
                                            title: title,
                                            date: date,
                                          ),
                                          const SizedBox(height: 25),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewNotePage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(11),
          elevation: 3,
          backgroundColor: const Color(0xff252525), // Warna latar belakang FAB
        ),
        child: const Icon(Icons.add, size: 48),
      ),
    );
  }
}
