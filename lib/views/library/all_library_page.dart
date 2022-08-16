import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/user_cubit.dart';

import 'package:game_lib_app/models/game/game.dart';
import 'package:game_lib_app/models/user.dart';
import 'package:game_lib_app/repositories/igdb_repository.dart';
import 'package:game_lib_app/views/details_page/details_page.dart';
import 'package:game_lib_app/widgets/favourite_games_dialog.dart/favourite_game_dialog.dart';
import 'package:get/get.dart';

class LibraryAll extends StatelessWidget {
  final UserListNames listName;
  const LibraryAll({Key? key, required this.listName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, User>(
      builder: (context, state) {
        List<Game> pageList;
        switch (listName) {
          case UserListNames.favGames:
            pageList = state.favGames;
            break;
          case UserListNames.playedGames:
            pageList = state.playedGames;
            break;
          case UserListNames.wishlistGames:
            pageList = state.wishlistGames;
            break;
        }

        return pageList.isNotEmpty
            ? ListView.builder(
                itemCount: pageList.length,
                itemBuilder: (context, index) {
                  Game game = pageList[index];
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
                        ),
                      ),
                    ),
                  );
                })
            : Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 48),
                child: Column(
                  children: [
                    Icon(
                      Icons.library_add_rounded,
                      size: 70,
                      color: Colors.grey[300],
                    ),
                    Text('nothing_here'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
              );
      },
    );
  }
}
