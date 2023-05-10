// To parse this JSON data, do
//
//     final addNote = addNoteFromJson(jsonString);

import 'dart:convert';

AddNote addNoteFromJson(String str) => AddNote.fromJson(json.decode(str));

String addNoteToJson(AddNote data) => json.encode(data.toJson());

class AddNote {
  AddNote({
    required this.status,
    required this.statuscode,
  });

  String status;
  int statuscode;

  factory AddNote.fromJson(Map<String, dynamic> json) => AddNote(
    status: json["Status"],
    statuscode: json["statuscode"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "statuscode": statuscode,
  };
}
