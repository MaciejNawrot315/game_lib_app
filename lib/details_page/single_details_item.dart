import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SingleDetailsLineIfExists extends StatelessWidget {
  const SingleDetailsLineIfExists(
      {Key? key, required this.item, required this.value})
      : super(key: key);
  final String item, value;
  @override
  Widget build(BuildContext context) {
    if (value == "") {
      return Container();
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
