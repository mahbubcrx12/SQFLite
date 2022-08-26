import 'package:day39_sqflite/add_contact.dart';
import 'package:day39_sqflite/contact.dart';
import 'package:day39_sqflite/db_helper.dart';
import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Local DB SQFLite")),
      body: FutureBuilder<List<Contact>>(
        future: DBHelper.raedContact(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Loading...")
                ],
              ),
            );
          }
          return snapshot.data!.isEmpty
              ? Center(
                  child: Text("No Data"),
                )
              : ListView(
                  children: snapshot.data!.map((contacts) {
                    return Center(
                      child: Card(
                        elevation: 10,
                        child: ListTile(
                          title: Text("${contacts.name}"),
                          subtitle: Text("${contacts.contact}"),
                        ),
                      ),
                    );
                  }).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final refresh = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddContact()));

          if (refresh) {
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
