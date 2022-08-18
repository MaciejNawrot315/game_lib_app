import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/auth/auth_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/user_cubit.dart';
import 'package:game_lib_app/models/game/game.dart';
import 'package:game_lib_app/widgets/my_snack_bar.dart';
import 'package:get/get.dart';

class AddToListButton extends StatelessWidget {
  final Game game;
  final UserListNames listName;
  final String removeTooltip;
  final String addTooltip;
  final IconData icon;
  final Color activeColor;
  const AddToListButton({
    Key? key,
    required this.game,
    required this.removeTooltip,
    required this.addTooltip,
    required this.icon,
    required this.activeColor,
    required this.listName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserCubit cubit = context.watch<UserCubit>();
    return cubit.containsInList(game, listName)
        ? Tooltip(
            message: removeTooltip,
            child: IconButton(
                onPressed: () {
                  cubit.removeGameFromList(game, listName);
                },
                icon: Icon(
                  icon,
                  color: activeColor,
                )),
          )
        : Tooltip(
            message: addTooltip,
            child: IconButton(
              onPressed: () {
                if (context.read<AuthBloc>().state.authStatus !=
                    AuthStatus.authenticated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    MySnackBar(text: 'login_to_add'.tr),
                  );
                } else {
                  cubit.addGameToList(game, listName);
                }
              },
              icon: Icon(
                icon,
              ),
            ),
          );
  }
}
