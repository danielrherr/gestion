import 'package:flutter/material.dart';
import 'package:gestion/Components/drawer.dart';
import 'package:gestion/Provider/provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      drawer: const MyDrawer(),
      body: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return Column(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text("Dark Theme"),
                  trailing: Switch(
                      value: notifier.isDark,
                      onChanged: (value) => notifier.changeTheme())),
            ],
          );
        },
      ),
    );
  }
}
