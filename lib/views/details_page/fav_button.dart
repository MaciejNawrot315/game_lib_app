import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/cubit/fav_games_cubit.dart';
import 'package:game_lib_app/models/game/game.dart';
import 'package:get/get.dart';

class FavButton extends StatelessWidget {
  final Game game;
  const FavButton({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.watch<FavGamesCubit>().state.contains(game.id)
        ? Tooltip(
            message: 'remove_fav'.tr,
            child: IconButton(
                onPressed: () {
                  context.read<FavGamesCubit>().removeGame(game.id);
                },
                icon: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.pink,
                )),
          )
        : Tooltip(
            message: 'add_fav'.tr,
            child: IconButton(
              onPressed: () {
                context.read<FavGamesCubit>().addGame(game);
              },
              icon: const Icon(
                Icons.favorite_border_rounded,
              ),
            ),
          );
  }
}
