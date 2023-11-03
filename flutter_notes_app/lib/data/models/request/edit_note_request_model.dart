import 'dart:convert';

class EditNoteRequestModel {
  final String title;
  final String description;
  final String labelColor;

  EditNoteRequestModel( {
    required this.title,
    required this.description,
    required this.labelColor,
  });

  factory EditNoteRequestModel.fromRawJson(String str) =>
      EditNoteRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EditNoteRequestModel.fromJson(Map<String, dynamic> json) =>
      EditNoteRequestModel(
        title: json["title"],
        description: json["description"],
        labelColor: json["label_color"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "label_color": labelColor,
      };
}
