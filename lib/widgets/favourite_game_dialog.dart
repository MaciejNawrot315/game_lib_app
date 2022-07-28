import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/cubit/fav_games_cubit.dart';
import 'package:game_lib_app/cubit/played_games_cubit.dart';
import 'package:game_lib_app/cubit/wishlist_games_cubit.dart';
import 'package:game_lib_app/game/game.dart';
import 'package:get/get.dart';

class FavDialog extends StatelessWidget {
  final Game game;
  const FavDialog({Key? key, required this.game}) : super(key: key);
  void addToFavourites(BuildContext context) {
    context.read<FavGamesCubit>().addGame(game);
    Navigator.of(context).pop();
  }

  void addToPlayed(BuildContext context) {
    context.read<PlayedGamesCubit>().addGame(game);
    Navigator.of(context).pop();
  }

  void addTowishlist(BuildContext context) {
    context.read<WishlistGamesCubit>().addGame(game);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
          insetPadding: EdgeInsets.zero,
          alignment: Alignment.bottomCenter,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextButton(
                  onPressed: () => addToFavourites(context),
                  child: Text('add_fav'.tr)),
              const Divider(color: Colors.white30),
              TextButton(
                  onPressed: () => addToPlayed(context),
                  child: Text('add_played'.tr)),
              const Divider(color: Colors.white30),
              TextButton(
                  onPressed: () => addTowishlist(context),
                  child: Text('add_wishlist'.tr))
            ],
          )),
    );
  }
}
