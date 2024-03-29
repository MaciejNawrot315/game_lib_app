import 'package:flutter/material.dart';

class SingleDetailsLineIfExists extends StatelessWidget {
  final String item, value;

  const SingleDetailsLineIfExists({
    Key? key,
    required this.item,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value == "") {
      return const SizedBox();
    }
    return Row(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.25,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('$item:',
              style: TextStyle(color: Colors.grey[700], fontSize: 12)),
        ),
      ),
      Flexible(
        child: Text(
          value,
          overflow: TextOverflow.clip,
        ),
      )
    ]);
  }
}
