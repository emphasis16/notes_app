import 'package:flutter/material.dart';
import 'package:flutter_notes_app/data/models/request/edit_note_request_model.dart';
import 'package:flutter_notes_app/data/models/request/new_notes_request_model.dart';
import 'package:flutter_notes_app/data/models/response/edit_note_response_model.dart';
import 'package:flutter_notes_app/data/models/response/new_notes_response_model.dart';
import 'package:flutter_notes_app/data/models/response/notes_reponse_model.dart';
import 'package:http/http.dart' as http;

class NotesRemoteDatasource {
  String baseUrl = 'http://172.20.2.80:3333/notes';

  // get all notes
  Future<NotesResponseModel> getNotes() async {
    final response = await http.get(
      Uri.parse(baseUrl),
    );
    if (response.statusCode == 200) {
      return NotesResponseModel.fromRawJson(response.body);
    } else {
      throw Exception('Failed to load task');
    }
  }

  // create new note
  Future<NewNoteResponseModel> createNote(NewNoteRequestModel data) async {
    debugPrint('Berhasil membuat model');
    final response = await http.post(
        Uri.parse(baseUrl),
        body: data.toRawJson(),
        headers: {
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      debugPrint('Berhasil post');
      return NewNoteResponseModel.fromRawJson(response.body);
    } else {
      throw Exception('Failed to create task');
    }
  }

  // delete note
  Future<void> deleteNote(String noteId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$noteId'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }

  // update note
  Future<EditNoteResponseModel> editNote(
      {required EditNoteRequestModel data, required String noteId}) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$noteId'),
      body: data.toRawJson(),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return EditNoteResponseModel.fromRawJson(response.body);
    } else {
      throw Exception('Failed to update task');
    }
  }
}
