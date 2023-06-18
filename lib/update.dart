import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/urls.dart';

import 'Note.dart';

class UpdateNote extends StatefulWidget {
  Note notes;
  UpdateNote({required this.notes});

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  final textController = TextEditingController();

  void initState() {
    textController.text = widget.notes.note!;
    super.initState();
  }

  _createNote() async {
    print(widget.notes.id);
    http.Response response = await http.put(API.updateUrl(widget.notes!.id),
        body: {"body": textController.text.trim()});
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: textController,
          ),
          ElevatedButton(
              onPressed: () => _createNote(), child: Text("Update Note"))
        ],
      ),
    );
  }
}
