import 'package:flutter/material.dart';

class RemoveButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const RemoveButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.red),
            ),
            const Icon(
              Icons.delete_outline_rounded,
              color: Colors.red,
            )
          ],
        ));
  }
}
