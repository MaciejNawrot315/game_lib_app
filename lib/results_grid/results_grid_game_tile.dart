import 'package:flutter/material.dart';
import 'package:game_lib_app/details_page/details_page.dart';
import 'package:game_lib_app/resource_manager.dart';

import 'package:game_lib_app/game/game.dart';

class ResultsGameTile extends StatelessWidget {
  final int index;
  final ResourceManager resourceManager;
  late final Game game;

  ResultsGameTile({
    Key? key,
    required this.index,
    required this.resourceManager,
  })  : game = resourceManager.resaultsGamesLoaded[index],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Image image = Image.network(
      ResourceManager.getPictureWithResolution(game.cover!.url, '720p'),
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
                        builder: (context) => DetailsPage(
                            gameID: game.id, resMan: widget.resourceManager),
                      ),
                    );
                  },
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
                                    game.name!,
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
                                  Text((game.rating! / 20.0)
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
