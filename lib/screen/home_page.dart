import 'package:flutter/material.dart';
import 'package:sqlit_prctice/data/local/db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> allNotes = [];
  DBHelper? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = DBHelper.getInstance;
    getNotes();
  }

  void getNotes() async {
    allNotes = await dbRef!.getallnotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      // all notes visible
      body: allNotes.isNotEmpty
          ? ListView.builder(
              itemCount: allNotes.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: Text(allNotes[index][DBHelper.Column_Note_Sn]),
                  title: Text(allNotes[index][DBHelper.Column_Note_title]),
                  subtitle: Text(allNotes[index][DBHelper.Column_Note_desc]),
                );
              })
          : Center(
              child: Text("no notes avliable"),
            ),
      floatingActionButton: FloatingActionButton(
        // note addeds
        onPressed: () {
          dbRef!.addNote(mTitle: "anurag", mDesc: "tiwari");
          getNotes();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
