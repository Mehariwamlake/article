import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({required this.labelText, required this.textEditingController});
  final String labelText;
  TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height * 0.06,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: labelText,
        ),
      ),
    );
  }
}
