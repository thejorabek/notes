import 'package:flutter/material.dart';
import 'package:list/provider/delete_provider.dart';
import 'package:list/provider/notes_provider.dart';
import 'package:provider/provider.dart';

class Delete extends StatefulWidget {
  const Delete({Key? key}) : super(key: key);

  @override
  State<Delete> createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  @override
  Widget build(BuildContext context) {
    final delete = context.watch<DeleteProvider>();
    final notes = context.watch<NotesProvider>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Deleted Notes'),
          centerTitle: true,
        ),
        body: delete.delete.isNotEmpty
            ? ListView.builder(
                itemCount: delete.delete.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: GestureDetector(
                      child: ListTile(
                          title: Text(delete.delete[index]['title']),
                          subtitle: Text(delete.delete[index]['subtitle']),
                          trailing: IconButton(
                            icon: const Icon(Icons.restart_alt),
                            onPressed: () {
                              notes.addToNotes(delete.delete[index]);
                              delete.deleteNote(index);
                            },
                          )),
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Are You Sure?'),
                                  content: Text('This Notes Will Be Deleted!'),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('No')),
                                    ElevatedButton(
                                        onPressed: () {
                                          delete.deleteNote(index);
                                          Navigator.pop(context);
                                        },
                                        child: Text('Yes'))
                                  ],
                                ));
                      },
                    ),
                  );
                }))
            : Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
                Icon(
                  Icons.delete_forever,
                  size: 100,
                ),
                Text(
                  'Deleted Notes Empty',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                )
              ])));
  }
}
