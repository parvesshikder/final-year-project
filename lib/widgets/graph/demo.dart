import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TasksPage extends StatelessWidget {
  final _controller = TextEditingController();

  TasksPage({Key key}) : super(key: key);

  void _saveTask() {
    final taskName = _controller.text;

    FirebaseFirestore.instance.collection("tasks").add({"name": taskName});

    _controller.clear();
  }

  Widget _buildList(QuerySnapshot snapshot) {
    return ListView.builder(
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];

          return Dismissible(
            key: Key(doc.id),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              // delete the doc from the database
              FirebaseFirestore.instance
                  .collection("tasks")
                  .doc(doc.id)
                  .delete();
            },
            child: ListTile(title: Text(doc["name"])),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Simple TODOList")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(children: [
              Expanded(
                  child: TextField(
                controller: _controller,
                decoration: const InputDecoration(hintText: "Enter task"),
              )),
              // ignore: deprecated_member_use
              FlatButton(
                child:
                    const Text("Save", style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: () {
                  _saveTask();
                },
              )
            ]),
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("tasks").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const LinearProgressIndicator();
                  return Expanded(child: _buildList(snapshot.data));
                })
          ]),
        ));
  }
}
