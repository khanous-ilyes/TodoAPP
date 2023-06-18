class Note {
  int id;
  String? note;
  Note({required this.id, required this.note});
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'body': this.note,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(id: json['id'], note: json['body']);
  }
}
