import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData icon;
  final TextEditingController? controller;
  final String hintText;
  final FormFieldValidator? validator;
  const InputField(
      {super.key,
      this.controller,
      this.validator,
      required this.hintText,
      required this.icon});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextFormField(
        validator: validator,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: Colors.indigo,
          ),
          labelText: hintText,
          labelStyle: const TextStyle(color: Colors.indigo),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(.5),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.indigo,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red.shade900,
            ),
          ),
        ),
      ),
    );
  }
}
