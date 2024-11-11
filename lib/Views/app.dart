import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion/AuthBloc/auth_bloc.dart';
import 'package:gestion/DatabaseHelper/repository.dart';
import 'package:gestion/Provider/provider.dart';
import 'package:gestion/Views/Auth/login.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(Repository()),
      child: ChangeNotifierProvider(
        create: (BuildContext context) => UiProvider()..init(),
        
        child: Consumer<UiProvider>(
          builder: (context, UiProvider notifier, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Gestion",
              initialRoute: "/",
              themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
              darkTheme:
                  notifier.isDark ? notifier.darkTheme : notifier.lightTheme,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const LoginPage(),
            );
          },
        ),
      ),
    );
  }
}
