import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/cubit/games_cubits.dart';

import 'package:game_lib_app/models/game/game.dart';

import 'package:game_lib_app/widgets/favourite_games_dialog.dart/add_button.dart';
import 'package:game_lib_app/widgets/favourite_games_dialog.dart/remove_button.dart';
import 'package:get/get.dart';

class FavDialog extends StatelessWidget {
  final Game game;
  const FavDialog({Key? key, required this.game}) : super(key: key);

  SnackBar makeSnackBar(String text) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10.0),
      backgroundColor: Colors.white,
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  void addToFavourites(BuildContext context) {
    context.read<FavGamesCubit>().addGame(game);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(makeSnackBar('fav_added'.tr));
  }

  void addToPlayed(BuildContext context) {
    context.read<PlayedGamesCubit>().addGame(game);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(makeSnackBar('played_added'.tr));
  }

  void addToWishlist(BuildContext context) {
    context.read<WishlistGamesCubit>().addGame(game);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context)
        .showSnackBar(makeSnackBar('whitelist_added'.tr));
  }

  void removeFromFavourites(BuildContext context) {
    context.read<FavGamesCubit>().removeGame(game.id);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(makeSnackBar('fav_removed'.tr));
  }

  void removeFromPlayed(BuildContext context) {
    context.read<PlayedGamesCubit>().removeGame(game.id);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context)
        .showSnackBar(makeSnackBar('played_removed'.tr));
  }

  void removeFromWishlist(BuildContext context) {
    context.read<WishlistGamesCubit>().removeGame(game.id);
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context)
        .showSnackBar(makeSnackBar('wishlist_removed'.tr));
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Dialog(
          insetPadding: EdgeInsets.zero,
          alignment: Alignment.bottomCenter,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            shrinkWrap: true,
            children: [
              context
                      .watch<FavGamesCubit>()
                      .state
                      .any((elemGame) => elemGame.id == game.id)
                  ? RemoveButton(
                      onPressed: () => removeFromFavourites(context),
                      text: 'remove_fav'.tr,
                    )
                  : AddButton(
                      onPressed: () => addToFavourites(context),
                      text: 'add_fav'.tr),
              const Divider(color: Colors.white30),
              context
                      .watch<PlayedGamesCubit>()
                      .state
                      .any((elemGame) => elemGame.id == game.id)
                  ? RemoveButton(
                      onPressed: () => removeFromPlayed(context),
                      text: 'remove_played'.tr,
                    )
                  : AddButton(
                      onPressed: () => addToPlayed(context),
                      text: 'add_played'.tr),
              const Divider(color: Colors.white30),
              context
                      .watch<WishlistGamesCubit>()
                      .state
                      .any((elemGame) => elemGame.id == game.id)
                  ? RemoveButton(
                      onPressed: () => removeFromWishlist(context),
                      text: 'remove_wishlist'.tr,
                    )
                  : AddButton(
                      onPressed: () => addToWishlist(context),
                      text: 'add_wishlist'.tr),
            ],
          )),
    );
  }
}
