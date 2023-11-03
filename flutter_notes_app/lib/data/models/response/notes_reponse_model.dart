import 'dart:convert';

class NotesResponseModel {
  final int code;
  final String status;
  final List<Note> data;

  NotesResponseModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory NotesResponseModel.fromRawJson(String str) =>
      NotesResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotesResponseModel.fromJson(Map<String, dynamic> json) =>
      NotesResponseModel(
        code: json["code"],
        status: json["status"],
        data: List<Note>.from(json["data"].map((x) => Note.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Note {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String labelColor;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.labelColor,
  });

  factory Note.fromRawJson(String str) => Note.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        labelColor: json["label_color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "label_color": labelColor,
      };
}
