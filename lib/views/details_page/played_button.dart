import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/cubit/played_games_cubit.dart';

import 'package:game_lib_app/models/game/game.dart';
import 'package:get/get.dart';

class PlayedButton extends StatelessWidget {
  final Game game;
  const PlayedButton({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.watch<PlayedGamesCubit>().state.contains(game.id)
        ? Tooltip(
            message: 'remove_played'.tr,
            child: IconButton(
                onPressed: () {
                  context.read<PlayedGamesCubit>().removeGame(game.id);
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                )),
          )
        : Tooltip(
            message: 'add_played'.tr,
            child: IconButton(
              onPressed: () {
                context.read<PlayedGamesCubit>().addGame(game);
              },
              icon: const Icon(
                Icons.check,
              ),
            ),
          );
  }
}
