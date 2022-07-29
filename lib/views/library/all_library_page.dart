import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/cubit/fav_games_cubit.dart';
import 'package:game_lib_app/cubit/list_state.dart';
import 'package:game_lib_app/cubit/played_games_cubit.dart';
import 'package:game_lib_app/cubit/wishlist_games_cubit.dart';

import 'package:game_lib_app/models/game/game.dart';
import 'package:game_lib_app/repositories/igdb_repository.dart';
import 'package:game_lib_app/views/details_page/details_page.dart';
import 'package:game_lib_app/widgets/favourite_games_dialog.dart/favourite_game_dialog.dart';
import 'package:get/get.dart';

class LibraryAll extends StatelessWidget {
  int count = 0;
  final int id;
  LibraryAll({Key? key, required this.id}) : super(key: key);

  String makeTooltip(List<Game> state) {
    String message = 'cats:';
    for (Game game in state) {
      message += '${game.id}';
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    switch (id) {
      case 0:
        return BlocBuilder<FavGamesCubit, FavGamesState>(
            builder: (context, state) {
          return myListView(state, context);
        });

      case 1:
        return BlocBuilder<PlayedGamesCubit, PlayedGamesState>(
            builder: (context, state) {
          return myListView(state, context);
        });

      case 2:
        return BlocBuilder<WishlistGamesCubit, WishlistGamesState>(
            builder: (context, state) {
          return myListView(state, context);
        });

      default:
        {
          return Container(color: Colors.red);
        }
    }
  }

  Widget myListView(ListState state, context) {
    int listLength = state.list.length;
    return listLength > 0
        ? ListView.builder(
            itemCount: listLength,
            itemBuilder: (context, index) {
              Game game = state.list[index];
              return GestureDetector(
                  onLongPress: () => showDialog(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<FavGamesCubit>(),
                          child: BlocProvider.value(
                            value: context.read<PlayedGamesCubit>(),
                            child: BlocProvider.value(
                              value: context.read<WishlistGamesCubit>(),
                              child: FavDialog(
                                game: game,
                              ),
                            ),
                          ),
                        ),
                      ),
                  child: ListTile(
                    leading: SizedBox(
                      width: 45,
                      child: game.cover?.url != null
                          ? Image.network(
                              IgdbRepository.getPictureWithResolution(
                                  game.cover!.url, 'thumb'),
                              fit: BoxFit.fitWidth,
                            )
                          : const SizedBox(),
                    ),
                    title: Text(
                      game.name ?? "",
                      style: const TextStyle(color: Colors.white),
                      overflow: TextOverflow.clip,
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<FavGamesCubit>(),
                          child: BlocProvider.value(
                            value: context.read<PlayedGamesCubit>(),
                            child: BlocProvider.value(
                                value: context.read<WishlistGamesCubit>(),
                                child: DetailsPage(
                                  gameID: game.id,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ));
            })
        : Container(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 48),
            child: Text('nothing_here'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)),
          );
  }
}
