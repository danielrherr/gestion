import 'package:flutter/material.dart';
import 'package:gestion/Provider/provider.dart';
import 'package:gestion/Views/Auth/login.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UiProvider()..init(),
      child: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Gestion",
            themeMode: notifier.isDark? ThemeMode.dark: ThemeMode.light,
            darkTheme: notifier.isDark? notifier.darkTheme:notifier.lightTheme,
            theme:ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const LoginPage(),
          );
        },
      ),
    );
  }
}
