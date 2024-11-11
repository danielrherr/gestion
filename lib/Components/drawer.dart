import 'package:flutter/material.dart';
import 'package:gestion/Views/home.dart';
import 'package:gestion/Views/settings.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "Daniel Rodolfo Herr",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue[200],
              foregroundColor: Theme.of(context).canvasColor,
              child: Text(
                "D",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.blue[900],
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.lightBlue,
            ),
            onDetailsPressed: () {
              //  Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              "Home",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            leading: const Icon(
              Icons.settings_rounded,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (constext) => const Home()));
            },
          ),
          ListTile(
            title: const Text(
              "Settings",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            leading: const Icon(
              Icons.settings_rounded,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (constext) => const Settings()));
            },
          ),
        ],
      ),
    );
  }
}
