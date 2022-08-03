import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/auth/auth_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/games_cubits.dart';

import 'package:game_lib_app/models/game/game.dart';
import 'package:game_lib_app/widgets/my_snack_bar.dart';
import 'package:get/get.dart';

class AddToListButton extends StatelessWidget {
  final Game game;
  final GamesCubit cubit;
  final String removeTooltip;
  final String addTooltip;
  final IconData icon;
  final Color activeColor;
  const AddToListButton({
    Key? key,
    required this.game,
    required this.cubit,
    required this.removeTooltip,
    required this.addTooltip,
    required this.icon,
    required this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cubit.state.any((elemGame) => elemGame.id == game.id)
        ? Tooltip(
            message: removeTooltip,
            child: IconButton(
                onPressed: () {
                  cubit.removeGame(game.id);
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
                  ScaffoldMessenger.of(context)
                      .showSnackBar(MySnackBar(text: 'login_to_add'.tr));
                } else {
                  cubit.addGame(game);
                }
              },
              icon: Icon(
                icon,
              ),
            ),
          );
  }
}
