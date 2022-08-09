import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/auth/auth_bloc.dart';

class AddButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const AddButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: context.read<AuthBloc>().state.authStatus ==
                AuthStatus.authenticated
            ? onPressed
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            const Icon(Icons.add),
          ],
        ));
  }
}
