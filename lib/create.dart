import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/urls.dart';

class CreateNote extends StatelessWidget {
  final textController = TextEditingController();
  _createNote() async {
    http.Response response = await http.post(Uri.parse(API.create),
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
              onPressed: () => _createNote(), child: Text("create Note"))
        ],
      ),
    );
  }
}
