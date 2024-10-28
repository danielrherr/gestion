import 'package:flutter/material.dart';
import 'package:gestion/Components/button.dart';
import 'package:gestion/Components/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usuarioController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .6,
                  // height: 250,
                  child: Hero(
                    tag:"image",
                    child: Image.asset("assets/logo.jpg"),
                  ),
                ),
                const ListTile(
                  contentPadding: EdgeInsets.only(left: 15),
                  title: Text(
                    "Gestion",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                InputField(
                  controller: usuarioController,
                  hintText: "User Name",
                  icon: Icons.account_circle_rounded,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "User Name is required";
                    }
                    return null;
                  },
                ),
                InputField(
                  controller: passwordController,
                  hintText: "Password",
                  icon: Icons.lock,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                ),
                Button(
                  label: "LOGIN",
                  onTap: () {
                    if (formKey.currentState!.validate()) {}
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
