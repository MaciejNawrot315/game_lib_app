import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const AddButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(text), const Icon(Icons.add)],
        ));
  }
}
