import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/games_cubits.dart';

import 'package:game_lib_app/models/game/game.dart';

import 'package:game_lib_app/widgets/favourite_games_dialog.dart/add_button.dart';
import 'package:game_lib_app/widgets/favourite_games_dialog.dart/remove_button.dart';
import 'package:game_lib_app/widgets/my_snack_bar.dart';
import 'package:get/get.dart';

class FavDialog extends StatelessWidget {
  final Game game;
  const FavDialog({Key? key, required this.game}) : super(key: key);

  void addToList(BuildContext context, GamesCubit cubit, String text) {
    cubit.addGame(game);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(text: text));
  }

  void removeFromList(BuildContext context, GamesCubit cubit, String text) {
    cubit.removeGame(game.id);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context)
        .showSnackBar(MySnackBar(text: 'fav_removed'.tr));
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Dialog(
          insetPadding: EdgeInsets.zero,
          alignment: Alignment.bottomCenter,
          backgroundColor: Colors.white,
          child: ListView(
            shrinkWrap: true,
            children: [
              context
                      .watch<FavGamesCubit>()
                      .state
                      .any((elemGame) => elemGame.id == game.id)
                  ? RemoveButton(
                      onPressed: () => removeFromList(context,
                          context.read<FavGamesCubit>(), 'fav_removed'.tr),
                      text: 'remove_fav'.tr,
                    )
                  : AddButton(
                      onPressed: () => addToList(context,
                          context.read<FavGamesCubit>(), 'fav_added'.tr),
                      text: 'add_fav'.tr),
              const Divider(color: Colors.white30),
              context
                      .watch<PlayedGamesCubit>()
                      .state
                      .any((elemGame) => elemGame.id == game.id)
                  ? RemoveButton(
                      onPressed: () => removeFromList(
                          context,
                          context.read<PlayedGamesCubit>(),
                          'played_removed'.tr),
                      text: 'remove_played'.tr,
                    )
                  : AddButton(
                      onPressed: () => addToList(context,
                          context.read<PlayedGamesCubit>(), 'played_added'.tr),
                      text: 'add_played'.tr),
              const Divider(color: Colors.white30),
              context
                      .watch<WishlistGamesCubit>()
                      .state
                      .any((elemGame) => elemGame.id == game.id)
                  ? RemoveButton(
                      onPressed: () => removeFromList(
                          context,
                          context.read<WishlistGamesCubit>(),
                          'wishlist_removed'.tr),
                      text: 'remove_wishlist'.tr,
                    )
                  : AddButton(
                      onPressed: () => addToList(
                          context,
                          context.read<WishlistGamesCubit>(),
                          'wishlist_added'.tr),
                      text: 'add_wishlist'.tr),
            ],
          )),
    );
  }
}
