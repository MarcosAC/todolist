import 'package:flutter/material.dart';

class TextFieldCustom extends StatefulWidget {
  const TextFieldCustom({super.key, this.label, this.textController});

  final String? label;
  final TextEditingController? textController;

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextField(
        controller: widget.textController,
        decoration: InputDecoration(
          labelText: widget.label,
          contentPadding: const EdgeInsets.all(10),
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    );
  }
}