import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final double buttonHeight;
  final VoidCallback? onTap;
  const Button(
      {super.key, required this.label, this.onTap, this.buttonHeight = 60});
  @override
  Widget build(BuildContext context) {
   
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width * .98,
      height: buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.indigo),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
