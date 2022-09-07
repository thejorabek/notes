import 'package:flutter/material.dart';
import 'package:list/home/home_page.dart';

class Delete extends StatefulWidget {
  const Delete({Key? key}) : super(key: key);

  @override
  State<Delete> createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Deleted Notes'),
          centerTitle: true,
        ),
        body: delete.isNotEmpty
            ? ListView.builder(
                itemCount: delete.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: GestureDetector(
                      child: ListTile(
                          title: Text(delete[index]['title']),
                          subtitle: Text(delete[index]['subtitle']),
                          trailing: IconButton(
                            icon: const Icon(Icons.restart_alt),
                            onPressed: () {
                              setState(() {
                                data.add(delete.removeAt(index));
                              });
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
                                          setState(() {
                                            delete.removeAt(index);
                                          });
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
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  Icons.delete_forever,
                  size: 100,
                ),
                const Text(
                  'Deleted Notes Empty',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                )
              ])));
  }
}

List<Map<String, dynamic>> delete = [];
