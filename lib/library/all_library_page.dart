import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/cubit/fav_games_cubit.dart';
import 'package:game_lib_app/details_page/details_page.dart';
import 'package:game_lib_app/game/game.dart';
import 'package:game_lib_app/repositories/igdb_repository.dart';
import 'package:game_lib_app/widgets/favourite_game_dialog.dart';

class LibraryAll extends StatelessWidget {
  int count = 0;
  LibraryAll({Key? key}) : super(key: key);

  String makeTooltip(List<Game> state) {
    String message = 'cats:';
    for (Game game in state) {
      message += '${game.id}';
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavGamesCubit, FavGamesState>(builder: (context, state) {
      return ListView.builder(
          itemCount: state.list.length,
          itemBuilder: (context, index) {
            Game game = state.list[index];
            return GestureDetector(
                onLongPress: () => showDialog(
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: context.read<FavGamesCubit>(),
                        child: FavDialog(
                          game: game,
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
                        child: DetailsPage(
                          gameID: game.id,
                        ),
                      ),
                    ),
                  ),
                ));
          });
    });
  }
}
