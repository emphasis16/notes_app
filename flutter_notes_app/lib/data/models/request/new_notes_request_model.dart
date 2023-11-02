import 'dart:convert';

class NewNoteRequestModel {
    final String title;
    final String description;

    NewNoteRequestModel({
        required this.title,
        required this.description,
    });

    factory NewNoteRequestModel.fromRawJson(String str) => NewNoteRequestModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NewNoteRequestModel.fromJson(Map<String, dynamic> json) => NewNoteRequestModel(
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
    };
}
