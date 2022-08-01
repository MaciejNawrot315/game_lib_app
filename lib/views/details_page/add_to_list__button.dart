import 'package:flutter/material.dart';

import 'package:game_lib_app/cubit/games_cubits.dart';

import 'package:game_lib_app/models/game/game.dart';

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
                cubit.addGame(game);
              },
              icon: Icon(
                icon,
              ),
            ),
          );
  }
}
