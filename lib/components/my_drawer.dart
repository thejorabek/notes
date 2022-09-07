import 'package:flutter/material.dart';
import 'package:list/home/settings_page.dart';
import 'package:list/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import '../home/deleted_notes_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  TextEditingController controller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, value, child) {
      return Drawer(
        
          width: 250,
          child: Column(
            children: [
              Image.asset('assets/notes.jpg'),
              Container(
                decoration: const BoxDecoration(color: Color.fromARGB(71, 0, 0, 0)),
                width: 250,
                height: 0.5,
              ),
              GestureDetector(
                child: const ListTile(
                  leading: Icon(Icons.delete),
                  title: Text(
                    'Trash',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Delete()));
                },
              ),
              Container(
                decoration: const BoxDecoration(color: Color.fromARGB(71, 0, 0, 0)),
                width: 250,
                height: 0.5,
              ),
              GestureDetector(
                  child: const ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(
                      'Settings',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                  }),
              Container(
                decoration: const BoxDecoration(color: Color.fromARGB(71, 0, 0, 0)),
                width: 250,
                height: 0.5,
              ),
            ],
          ));
    }));
  }
}
