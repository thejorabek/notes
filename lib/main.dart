import 'package:flutter/material.dart';
import 'package:list/provider/checkbox_provider.dart';
import 'package:list/provider/delete_provider.dart';
import 'package:list/provider/done_provider.dart';
import 'package:list/provider/notes_provider.dart';
import 'package:list/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'home/home_page.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ((context) => ThemeProvider())),
          ChangeNotifierProvider(create: (context) => CheckboxProvider()),
          ChangeNotifierProvider(create: (context)=>DoneProvider()),
          ChangeNotifierProvider(create: (context)=>DeleteProvider()),
          ChangeNotifierProvider(create: (context)=>NotesProvider())
        ],
        child: Consumer(
          builder: ((context, value, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomePage(),
              theme: context.watch<ThemeProvider>().isDark ? ThemeData.dark() : ThemeData.light(),
            );
          }),
        ));
  }
}
