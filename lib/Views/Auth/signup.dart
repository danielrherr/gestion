import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion/AuthBloc/auth_bloc.dart';
import 'package:gestion/Components/button.dart';
import 'package:gestion/Components/text_field.dart';
import 'package:gestion/Models/users.dart';
import 'package:gestion/Views/Auth/login.dart';
import 'package:gestion/Views/home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final fullName = TextEditingController();
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SuccessRegister) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Home()));
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
                    children: [
                      ListTile(
                        horizontalTitleGap: 5,
                        contentPadding: EdgeInsets.zero,
                        title: const Text("REGISTER"),
                        subtitle: const Text("Create new account"),
                        leading: Hero(
                            tag: "image",
                            child: Image.asset("assets/logo.jpg")),
                      ),
                      InputField(
                        hintText: "Full name",
                        controller: fullName,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Full name is required";
                          }
                          return null;
                        },
                        icon: Icons.person,
                      ),
                      InputField(
                        hintText: "Email",
                        controller: email,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Email name is required";
                          }
                          return null;
                        },
                        icon: Icons.email,
                      ),
                      InputField(
                        hintText: "Username",
                        controller: username,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Username is required";
                          }
                          return null;
                        },
                        icon: Icons.account_circle_rounded,
                      ),
                      InputField(
                        hintText: "Password",
                        controller: password,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                        icon: Icons.lock,
                      ),
                      InputField(
                        hintText: "Re-enter password.",
                        controller: confirmPassword,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Re-enter password is required";
                          } else if (password.text != confirmPassword.text) {
                            return "Password don't match";
                          }
                          return null;
                        },
                        icon: Icons.lock,
                      ),
                      state is Loading
                          ? const CircularProgressIndicator()
                          : Button(
                              label: 'REGISTER',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  context
                                      .read<AuthBloc>()
                                      .add(RegisterEvent(Users(
                                        fullName: fullName.text,
                                        email: email.text,
                                        username: username.text,
                                        password: password.text,
                                      )));
                                }
                              },
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              child: const Text(
                                "LOGIN",
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
