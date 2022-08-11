import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/user_cubit.dart';

import 'package:game_lib_app/models/game/game.dart';
import 'package:game_lib_app/models/user.dart';

import 'package:game_lib_app/widgets/favourite_games_dialog.dart/add_button.dart';
import 'package:game_lib_app/widgets/favourite_games_dialog.dart/remove_button.dart';
import 'package:game_lib_app/widgets/my_snack_bar.dart';
import 'package:get/get.dart';

class FavDialog extends StatelessWidget {
  final Game game;

  const FavDialog({
    Key? key,
    required this.game,
  }) : super(key: key);

  void addToList(BuildContext context, UserListNames listName, String text) {
    context.read<UserCubit>().addGameToList(game, listName);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(text: text));
  }

  void removeFromList(
      BuildContext context, UserListNames listName, String text) {
    context.read<UserCubit>().removeGameFromList(game, listName);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(text: text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, User>(
      builder: (context, state) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Dialog(
              insetPadding: EdgeInsets.zero,
              alignment: Alignment.bottomCenter,
              backgroundColor: Colors.white,
              child: ListView(
                shrinkWrap: true,
                children: [
                  state.favGames.any((elemGame) => elemGame.id == game.id)
                      ? RemoveButton(
                          onPressed: () => removeFromList(
                            context,
                            UserListNames.favGames,
                            'fav_removed'.tr,
                          ),
                          text: 'remove_fav'.tr,
                        )
                      : AddButton(
                          onPressed: () => addToList(
                                context,
                                UserListNames.favGames,
                                'fav_added'.tr,
                              ),
                          text: 'add_fav'.tr),
                  const Divider(color: Colors.white30),
                  state.playedGames.any((elemGame) => elemGame.id == game.id)
                      ? RemoveButton(
                          onPressed: () => removeFromList(
                            context,
                            UserListNames.playedGames,
                            'played_removed'.tr,
                          ),
                          text: 'remove_played'.tr,
                        )
                      : AddButton(
                          onPressed: () => addToList(
                                context,
                                UserListNames.playedGames,
                                'played_added'.tr,
                              ),
                          text: 'add_played'.tr),
                  const Divider(color: Colors.white30),
                  state.wishlistGames.any((elemGame) => elemGame.id == game.id)
                      ? RemoveButton(
                          onPressed: () => removeFromList(
                            context,
                            UserListNames.wishlistGames,
                            'wishlist_removed'.tr,
                          ),
                          text: 'remove_wishlist'.tr,
                        )
                      : AddButton(
                          onPressed: () => addToList(
                                context,
                                UserListNames.wishlistGames,
                                'wishlist_added'.tr,
                              ),
                          text: 'add_wishlist'.tr),
                ],
              )),
        );
      },
    );
  }
}
