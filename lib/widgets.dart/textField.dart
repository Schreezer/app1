import "package:flutter/material.dart";

class TField extends StatefulWidget {
  String hText;
  TextEditingController controller;
  TField({required this.hText, required this.controller, Key? key})
      : super(key: key);
  @override
  State<TField> createState() => _TFieldState();
}

class _TFieldState extends State<TField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
          hintText: widget.hText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );
  }
}
void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}