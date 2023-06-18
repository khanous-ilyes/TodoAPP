import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:todo_app/Note.dart';
import 'package:todo_app/create.dart';
import 'package:todo_app/update.dart';
import 'package:todo_app/urls.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  http.Client client = http.Client();
  RxList notes = [].obs;
  void initState() {
    _getNotes();
    super.initState();
  }

  _getNotes() async {
    notes.value = [];
    try {
      http.Response response = await client.get(Uri.parse(API.getNotes));
      print(response.body);
      List resbod = json.decode(response.body);
      print(resbod);
      resbod.forEach((element) {
        notes.add(Note.fromJson(element));
      });
      print(notes);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  _deleteNote(int id) {
    client.delete(API.deleteUrl(id));
    _getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text("ToDo"),
        ),
        body: RefreshIndicator(
          onRefresh: () => _getNotes(),
          child: ListView.builder(
            itemBuilder: (_, index) {
              return ListTile(
                onTap: () => Get.to(UpdateNote(
                  notes: notes[index],
                )),
                title: Text(notes[index].note),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteNote(notes[index].id);
                  },
                ),
              );
            },
            itemCount: notes.length,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(CreateNote());
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
