import 'dart:convert';

class EditNoteResponseModel {
    final int code;
    final String status;
    final Data data;

    EditNoteResponseModel({
        required this.code,
        required this.status,
        required this.data,
    });

    factory EditNoteResponseModel.fromRawJson(String str) => EditNoteResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EditNoteResponseModel.fromJson(Map<String, dynamic> json) => EditNoteResponseModel(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    final String title;
    final String description;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int id;

    Data({
        required this.title,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
        required this.id,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "id": id,
    };
}
