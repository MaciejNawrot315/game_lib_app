import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/games_cubits.dart';

import 'package:game_lib_app/models/game/game.dart';
import 'package:game_lib_app/repositories/igdb_repository.dart';
import 'package:game_lib_app/views/details_page/details_page.dart';
import 'package:game_lib_app/widgets/favourite_games_dialog.dart/favourite_game_dialog.dart';
import 'package:get/get.dart';

class LibraryAll extends StatelessWidget {
  final int id;
  const LibraryAll({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (id) {
      case 0:
        return BlocBuilder<FavGamesCubit, List<Game>>(
            builder: (context, state) {
          return myListView(state);
        });

      case 1:
        return BlocBuilder<PlayedGamesCubit, List<Game>>(
            builder: (context, state) {
          return myListView(state);
        });

      case 2:
        return BlocBuilder<WishlistGamesCubit, List<Game>>(
            builder: (context, state) {
          return myListView(state);
        });

      default:
        {
          return Container(color: Colors.red);
        }
    }
  }

  Widget myListView(List<Game> state) {
    return state.isNotEmpty
        ? ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              Game game = state[index];
              return GestureDetector(
                  onLongPress: () => showDialog(
                        context: context,
                        builder: (_) => FavDialog(
                          game: game,
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
                            builder: (_) => DetailsPage(
                              gameID: game.id,
                            ),
                          ))));
            })
        : Container(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 48),
            child: Text('nothing_here'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)),
          );
  }
}
