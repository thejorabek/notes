import 'package:flutter/material.dart';
import 'package:list/home/deleted_notes_page.dart';
import 'package:list/home/home_page.dart';

class DoneTabBar extends StatefulWidget {
  const DoneTabBar({Key? key}) : super(key: key);

  @override
  State<DoneTabBar> createState() => _DoneTabBarState();
}

class _DoneTabBarState extends State<DoneTabBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: starred.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_border, size: 100),
                  Text(
                    'No Starred Notes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: starred.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: ListTile(
                    title: Text(starred[index]['title']),
                    subtitle: Text(starred[index]['subtitle']),
                    trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        delete.add(starred.removeAt(index));
                      });
                    },
                    )
                  ),
                );
              })),
    );
  }
}

List<Map<String, dynamic>> starred = [];
