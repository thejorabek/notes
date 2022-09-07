import 'package:flutter/material.dart';
import 'package:list/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: context.watch<ThemeProvider>().isDark?null:Colors.amber,
      ),
      body: Consumer(
        builder: (context, value, child) {
          return ListTile(
            title: Text(
              context.watch<ThemeProvider>().isDark ? 'Dark theme' : 'Light theme',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            trailing: SwitcherButton(
              value: context.watch<ThemeProvider>().isDark,
              onChange: (v) {
                Provider.of<ThemeProvider>(context,listen: false).changeTheme();
                v = Provider.of<ThemeProvider>(context,listen: false).isDark;
              },
            ),
          );
        },
      ),
    );
  }
}
