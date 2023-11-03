import 'dart:convert';

class NewNoteRequestModel {
  final String title;
  final String description;
  final String labelColor;

  NewNoteRequestModel({
    required this.title,
    required this.description,
    required this.labelColor,
  });

  factory NewNoteRequestModel.fromRawJson(String str) =>
      NewNoteRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewNoteRequestModel.fromJson(Map<String, dynamic> json) =>
      NewNoteRequestModel(
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
