import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/cubit/wishlist_games_cubit.dart';

import 'package:game_lib_app/models/game/game.dart';
import 'package:get/get.dart';

class WishlistButton extends StatelessWidget {
  final Game game;
  const WishlistButton({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.watch<WishlistGamesCubit>().state.contains(game.id)
        ? Tooltip(
            message: 'remove_wishlist'.tr,
            child: IconButton(
                onPressed: () {
                  context.read<WishlistGamesCubit>().removeGame(game.id);
                },
                icon: const Icon(
                  Icons.shopping_bag_rounded,
                  color: Colors.blue,
                )),
          )
        : Tooltip(
            message: 'add_wishlist'.tr,
            child: IconButton(
              onPressed: () {
                context.read<WishlistGamesCubit>().addGame(game);
              },
              icon: const Icon(
                Icons.shopping_bag_rounded,
              ),
            ),
          );
  }
}
