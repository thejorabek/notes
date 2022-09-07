import 'package:flutter/material.dart';
import 'package:list/provider/delete_provider.dart';
import 'package:list/provider/done_provider.dart';
import 'package:provider/provider.dart';

class DoneTabBar extends StatefulWidget {
  const DoneTabBar({Key? key}) : super(key: key);

  @override
  State<DoneTabBar> createState() => _DoneTabBarState();
}

class _DoneTabBarState extends State<DoneTabBar> {
  @override
  Widget build(BuildContext context) {
    final delete = context.watch<DeleteProvider>();
    final done = context.watch<DoneProvider>();
    return Consumer(builder: ((context, value, child) {
      return Scaffold(
        body: context.watch<DoneProvider>().done.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.done, size: 100),
                    Text(
                      'No Doned Notes',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: context.watch<DoneProvider>().done.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: ListTile(
                        title: Text(context.watch<DoneProvider>().done[index]['title']),
                        subtitle: Text(context.watch<DoneProvider>().done[index]['subtitle']),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            delete.assNote(done.removeDone(index));
                          },
                        )),
                  );
                })),
      );
    }));
  }
}
