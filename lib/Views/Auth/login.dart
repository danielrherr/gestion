import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion/AuthBloc/auth_bloc.dart';
import 'package:gestion/Components/button.dart';
import 'package:gestion/Components/text_field.dart';
import 'package:gestion/Views/Auth/signup.dart';
import 'package:gestion/Views/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (constext) => const Home()));
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error.toString())));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        // height: 250,
                        child: Hero(
                          tag: "image",
                          child: Image.asset("assets/logo.jpg"),
                        ),
                      ),
                      InputField(
                        controller: username,
                        hintText: "UserName",
                        icon: Icons.account_circle_rounded,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "User Name is required";
                          }
                          return null;
                        },
                      ),
                      InputField(
                        controller: password,
                        hintText: "Password",
                        icon: Icons.lock,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                      ),
                      state is Loading
                          ? const CircularProgressIndicator()
                          : Button(
                              label: "LOGIN",
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                      LoginEvent(username.text, password.text));
                                }
                              },
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage()));
                              },
                              child: const Text(
                                "REGISTER",
                                style: TextStyle(color: Colors.purple),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
