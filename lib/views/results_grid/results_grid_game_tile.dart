import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/cubit/games_cubits.dart';

import 'package:game_lib_app/models/game/game.dart';
import 'package:game_lib_app/repositories/igdb_repository.dart';

import 'package:game_lib_app/views/details_page/details_page.dart';
import 'package:game_lib_app/widgets/favourite_games_dialog.dart/favourite_game_dialog.dart';

class ResultsGameTile extends StatelessWidget {
  final int index;

  final Game game;

  const ResultsGameTile({
    Key? key,
    required this.index,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image image = Image.network(
      IgdbRepository.getPictureWithResolution(game.cover!.url, '720p'),
      fit: BoxFit.fitWidth,
    );
    return SizedBox(
      width: image.width,
      height: image.height,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                GestureDetector(
                  child: Hero(
                    tag: "cover${game.cover!.url}",
                    child: image,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsPage(
                          gameID: game.id,
                        ),
                      ),
                    );
                  },
                  onLongPress: () => showDialog(
                    context: context,
                    builder: (_) => FavDialog(
                      game: game,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  height: 30,
                  child: SizedBox(
                      width: constraints.maxWidth,
                      height: 30,
                      child: Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment(0, -0.7),
                                  end: Alignment(0, 0.9),
                                  colors: [
                            Color.fromARGB(0, 0, 0, 0),
                            Colors.black
                          ])))),
                ),
                Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: constraints.maxWidth,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: DefaultTextStyle(
                          style: const TextStyle(color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: Tooltip(
                                  message: game.name,
                                  waitDuration: const Duration(seconds: 1),
                                  showDuration:
                                      const Duration(milliseconds: 100),
                                  preferBelow: false,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    game.name ?? "",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.75,
                                    child: const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  Text(((game.rating ?? 0.0) / 20.0)
                                      .toStringAsPrecision(3))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
              ],
            );
          }),
        ),
      ),
    );
  }
}
