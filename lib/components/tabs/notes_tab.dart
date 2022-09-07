import 'package:flutter/material.dart';
import 'package:list/provider/checkbox_provider.dart';
import 'package:list/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import '../../home/deleted_notes_page.dart';
import '../../home/home_page.dart';

class NotesTabBar extends StatefulWidget {
  const NotesTabBar({Key? key}) : super(key: key);

  @override
  State<NotesTabBar> createState() => _NotesTabBarState();
}

class _NotesTabBarState extends State<NotesTabBar> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: data.isNotEmpty
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: ((context, index) {
                  return Card(child: Consumer(
                    builder: ((context, value, child) {
                      return ListTile(
                          leading: RoundCheckBox(onTap: (v) {
                            context.read<CheckboxProvider>().makeChacked();
                            v = context.watch<CheckboxProvider>().isChecked;
                          }),
                          title: Text(data[index]['title']),
                          subtitle: Text(data[index]['subtitle']),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                delete.add(data.removeAt(index));
                              });
                            },
                          ));
                    }),
                  ));
                }))
            : Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.description_outlined, size: 100),
                  const Text(
                    'Notes Empty',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )
                ]),
              ),
        floatingActionButton: Consumer(
          builder: ((context, value, child) {
            return FloatingActionButton(
              backgroundColor: context.watch<ThemeProvider>().isDark ? null : Colors.amber,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          actions: [
                            ElevatedButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            ElevatedButton(
                                child: const Text('Add'),
                                onPressed: () {
                                  if (controller1.text.isNotEmpty && controller2.text.isNotEmpty) {
                                    data.add({'title': controller1.text, 'subtitle': controller2.text});
                                    controller1.clear();
                                    controller2.clear();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 2),
                                        content: Text('Title or Subtitle not corrected filled!'),
                                      ),
                                    );
                                  }
                                  controller1.clear();
                                  controller2.clear();
                                  Navigator.pop(context);
                                  setState(() {});
                                })
                          ],
                          title: const Text('Add Notes'),
                          content: SizedBox(
                            height: 100,
                            width: 150,
                            child: Column(children: [
                              TextFormField(
                                controller: controller1,
                                decoration: const InputDecoration(hintText: 'Title'),
                              ),
                              TextFormField(
                                controller: controller2,
                                decoration: const InputDecoration(
                                  hintText: 'Subtitle',
                                ),
                              ),
                            ]),
                          ),
                        ));
              },
              child: Icon(
                Icons.add,
                color: context.watch<ThemeProvider>().isDark ? null : Colors.black,
              ),
            );
          }),
        ));
  }
}
