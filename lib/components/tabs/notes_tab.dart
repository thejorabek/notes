import 'package:flutter/material.dart';
import 'package:list/provider/checkbox_provider.dart';
import 'package:list/provider/delete_provider.dart';
import 'package:list/provider/done_provider.dart';
import 'package:list/provider/notes_provider.dart';
import 'package:list/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

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
    final notes = context.watch<NotesProvider>();
    final checkbox = context.watch<CheckboxProvider>();
    final done = context.watch<DoneProvider>();
    final theme = context.watch<ThemeProvider>();
    final delete = context.watch<DeleteProvider>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: notes.notes.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: notes.notes.length,
                itemBuilder: ((context, index) {
                  return Card(child: Consumer(
                    builder: ((context, value, child) {
                      return ListTile(
                          leading: RoundCheckBox(
                              isChecked: checkbox.isChecked,
                              onTap: (v) {
                                v = checkbox.isChecked;
                                checkbox.makeChacked();
                                if (checkbox.isChecked) {
                                  done.addToDone(notes.notes[index]);
                                  Future.delayed(const Duration(seconds: 1)).then((value) => notes.removeNote(index));
                                } else {}
                              }),
                          title: Text(notes.notes[index]['title']),
                          subtitle: Text(notes.notes[index]['subtitle']),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              delete.assNote(notes.notes[index]);
                              notes.removeNote(index);
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
              backgroundColor: theme.isDark ? null : Colors.amber,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          actions: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(context.watch<ThemeProvider>().isDark ? null : Colors.amber)),
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(context.watch<ThemeProvider>().isDark ? null : Colors.amber)),
                                child: const Text('Add'),
                                onPressed: () {
                                  if (controller1.text.isNotEmpty && controller2.text.isNotEmpty) {
                                    notes.notes.add({'title': controller1.text, 'subtitle': controller2.text});
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
                            height: height * .17,
                            width: width * .2,
                            child: Column(children: [
                              TextFormField(
                                controller: controller1,
                                decoration: const InputDecoration(hintText: 'Title', border: OutlineInputBorder()),
                              ),
                              SizedBox(height: height * .01),
                              TextFormField(
                                controller: controller2,
                                decoration: const InputDecoration(hintText: 'Subtitle', border: OutlineInputBorder()),
                              ),
                            ]),
                          ),
                        ));
              },
              child: Icon(
                Icons.add,
                color: theme.isDark ? null : Colors.black,
              ),
            );
          }),
        ));
  }
}
