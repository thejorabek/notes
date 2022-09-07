import 'package:flutter/material.dart';
import 'package:list/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import '../components/tabs/archived_tab.dart';
import '../components/tabs/notes_tab.dart';
import '../components/tabs/starred_tab.dart';
import 'deleted_notes_page.dart';
import '../components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: index,
        length: 3,
        child: Consumer(
          builder: ((context, value, child) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: context.watch<ThemeProvider>().isDark ? null : Colors.amber,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Delete()));
                      },
                      icon: const Icon(Icons.search)),
                  const SizedBox(width: 15)
                ],
                centerTitle: true,
                bottom: TabBar(indicatorSize: TabBarIndicatorSize.label, indicatorColor: Colors.white, tabs: [
                  Tab(
                    text: tabs[0]['second'],
                  ),
                  Tab(
                    text: tabs[0]['first'],
                  ),
                  Tab(
                    text: tabs[0]['third'],
                  )
                ]),
              ),
              drawer: const MyDrawer(),
              body:const TabBarView(
                children: [
                  DoneTabBar(),
                  NotesTabBar(),
                  ArchivedTabBar(),
                ],
              ),
            );
          }),
        ));
  }
}

List<Map<String, dynamic>> data = [];
List<Map<String, dynamic>> tabs = [
  {
    'first': 'Notes',
    'second': 'Done',
    'third': 'Archived',
  }
];
