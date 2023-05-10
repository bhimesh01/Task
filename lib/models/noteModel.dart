class NoteModel {
  final int noteID;
  final String userName;
  final String note;
  final int timeSpent;

  NoteModel({
    required this.noteID,
    required this.userName,
    required this.note,
    required this.timeSpent,
  });

  factory NoteModel.fromJson(Map<String, dynamic> data) {
    final noteID = data['noteId'] as int;
    final userName = data['userName'] as String;
    final note = data['note'] as String;
    final timeSpent = data['timeSpend'] as int;

    return NoteModel(
        noteID: noteID, userName: userName, note: note, timeSpent: timeSpent);
  }
}
