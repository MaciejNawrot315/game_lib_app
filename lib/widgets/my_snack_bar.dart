import 'package:flutter/material.dart';

class MySnackBar extends SnackBar {
  final String text;
  MySnackBar({Key? key, required this.text})
      : super(
          key: key,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10.0),
          backgroundColor: Colors.white,
          content: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
          ),
        );
}
