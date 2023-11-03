// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_notes_app/custom_func/func.dart';
import 'package:flutter_notes_app/data/datasources/notes_remote_datasources.dart';
import 'package:flutter_notes_app/data/models/request/new_notes_request_model.dart';
import 'package:flutter_notes_app/pages/home_page.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({super.key});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  // Daftar keenam warna yang telah ditentukan
  List<Color> predefinedColors = [
    const Color(0xffFD99FF),
    const Color(0xffFF9E9E),
    const Color(0xff91F48F),
    const Color(0xffFFF599),
    const Color(0xff9EFFFF),
    const Color(0xffB69CFF),
  ];

  // Fungsi untuk memilih warna acak dari daftar warna yang telah ditentukan
  Color randomPredefinedColor() {
    Random random = Random();
    return predefinedColors[random.nextInt(predefinedColors.length)];
  }

  late TextEditingController titleController;
  late TextEditingController descController;
  late Color currentColor;

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
    titleController = TextEditingController();
    descController = TextEditingController();
    currentColor = randomPredefinedColor();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
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
                          Navigator.pop(context);
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
                      InkWell(
                        onTap: () async {
                          // implemen post
                          final model = NewNoteRequestModel(
                            title: titleController.text,
                            description: descController.text,
                            labelColor: CustomFunc.colorToHex(currentColor),
                          );
                          await NotesRemoteDatasource().createNote(model);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.white,
                              content: Text(
                                'Successfully create a note',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Container(
                          constraints: const BoxConstraints(
                            minHeight: 50,
                            minWidth: 50,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.save_outlined,
                            color: Color(0xff383B3B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  InkWell(
                    onTap: () {
                      _showColorPicker();
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
                    textInputAction: TextInputAction.done,
                    autofocus: true,
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
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(height: 37),
                  TextField(
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
