import 'package:flutter/material.dart';
import 'package:list/provider/delete_provider.dart';
import 'package:provider/provider.dart';

class ArchivedTabBar extends StatefulWidget {
  const ArchivedTabBar({Key? key}) : super(key: key);

  @override
  State<ArchivedTabBar> createState() => _ArchivedTabBarState();
}

class _ArchivedTabBarState extends State<ArchivedTabBar> {
  @override
  Widget build(BuildContext context) {
    final delete = context.watch<DeleteProvider>();
    return Scaffold(
      body: archived.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.archive_outlined,
                    size: 100,
                  ),
                  Text(
                    'No Archived Notes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: archived.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: ListTile(
                      title: Text(archived[index]['title']),
                      subtitle: Text(archived[index]['subtitle']),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            delete.delete.add(archived.removeAt(index));
                          });
                        },
                      )),
                );
              })),
    );
  }
}

List<Map<String, dynamic>> archived = [];
