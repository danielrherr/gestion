import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion/AuthBloc/auth_bloc.dart';
import 'package:gestion/Components/drawer.dart';
import 'package:gestion/Views/Auth/login.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LogoutState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            }
          },
          builder: (context, state) {
            if (state is Authenticated) {
              return Text(state.loggedInUser.fullName!);
            }
            return Container();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      drawer: const MyDrawer(),
      body: const Center(child: Text("Hello")),
    );
  }
}
