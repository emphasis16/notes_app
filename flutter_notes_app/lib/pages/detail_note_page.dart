// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_notes_app/custom_func/func.dart';
import 'package:flutter_notes_app/data/datasources/notes_remote_datasources.dart';
import 'package:flutter_notes_app/data/models/request/edit_note_request_model.dart';
import 'package:flutter_notes_app/data/models/response/notes_reponse_model.dart';

import 'home_page.dart';

class DetailNotePage extends StatefulWidget {
  final Note noteData;
  const DetailNotePage({super.key, required this.noteData});

  @override
  State<DetailNotePage> createState() => _DetailNotePageState();
}

class _DetailNotePageState extends State<DetailNotePage> {
  late TextEditingController titleController;
  late TextEditingController descController;
  late Color currentColor;
  FocusNode titleFocusNode = FocusNode();
  late bool isOnEdit;
  late bool isSaved;
  late String initialTitle;
  late String initialDesc;
  late Color initialColor;

  void changeColor(Color color) {
    setState(() {
      currentColor = color;
    });
  }

  void _showColorPicker() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ColorPicker(
                  pickerColor: currentColor,
                  onColorChanged: changeColor,
                  pickerAreaHeightPercent: 0.55,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    titleController = TextEditingController(text: widget.noteData.title);
    descController = TextEditingController(text: widget.noteData.description);
    currentColor = CustomFunc.hexStringToColor(widget.noteData.labelColor);
    isOnEdit = false;
    isSaved = false;
    initialDesc = widget.noteData.description;
    initialTitle = widget.noteData.title;
    initialColor = CustomFunc.hexStringToColor(widget.noteData.labelColor);
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    isOnEdit = false;
    isSaved = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff252525),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 75, right: 25, left: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          if (initialTitle == titleController.text &&
                              initialDesc == descController.text &&
                              initialColor == currentColor &&
                              isSaved == false) {
                            Navigator.pop(context);
                          } else {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                                (route) => false);
                          }
                        },
                        child: Container(
                          constraints: const BoxConstraints(
                            minHeight: 50,
                            minWidth: 50,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xff383B3B),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              final model = EditNoteRequestModel(
                                title: titleController.text,
                                description: descController.text,
                                labelColor: CustomFunc.colorToHex(currentColor),
                              );
                              debugPrint(model.labelColor);
                              setState(() {
                                isOnEdit = !isOnEdit;
                              });
                              if (isOnEdit) {
                                Future.delayed(Duration.zero, () {
                                  FocusScope.of(context).requestFocus(
                                      titleFocusNode); // Fokus pada TextField "title"
                                });
                              }
                              setState(() {
                                if (isOnEdit == false) {
                                  isSaved = true;
                                  debugPrint('is saved : $isSaved');
                                } else {
                                  isSaved = false;
                                }
                              });
                              // implemen put
                              if (isSaved) {
                                await NotesRemoteDatasource().editNote(
                                  data: model,
                                  noteId: widget.noteData.id.toString(),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Succesfully update a note',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 50,
                                minWidth: 50,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: isOnEdit
                                    ? Colors.white
                                    : const Color(0xff383B3B),
                              ),
                              child: Icon(
                                isOnEdit
                                    ? Icons.save_outlined
                                    : Icons.edit_outlined,
                                color: isOnEdit
                                    ? const Color(0xff383B3B)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  InkWell(
                    onTap: () {
                      if (isOnEdit) {
                        _showColorPicker();
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: currentColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Note Color Label',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff9a9a9a),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.edit,
                          color: Color(0xff9a9a9a),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    focusNode: titleFocusNode,
                    enabled: isOnEdit,
                    textInputAction: TextInputAction.done,
                    autofocus: isOnEdit,
                    controller: titleController,
                    maxLines: null,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(
                        fontSize: 35,
                        color: Color(0xff9a9a9a),
                      ),
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(height: 37),
                  TextField(
                    enabled: isOnEdit,
                    textInputAction: TextInputAction.done,
                    autofocus: false,
                    controller: descController,
                    maxLines: null,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type Something...',
                      hintStyle: TextStyle(
                        fontSize: 23,
                        color: Color(0xff9a9a9a),
                      ),
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
