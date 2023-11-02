import 'dart:convert';

class EditNoteRequestModel {
    final String title;
    final String description;

    EditNoteRequestModel({
        required this.title,
        required this.description,
    });

    factory EditNoteRequestModel.fromRawJson(String str) => EditNoteRequestModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EditNoteRequestModel.fromJson(Map<String, dynamic> json) => EditNoteRequestModel(
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
    };
}
