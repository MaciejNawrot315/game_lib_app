import 'package:flutter/material.dart';
import 'package:game_lib_app/details_page/details_page.dart';
import 'package:game_lib_app/resource_manager.dart';

import 'package:game_lib_app/game/game.dart';

class HomePageGameTile extends StatefulWidget {
  const HomePageGameTile(
      {Key? key,
      required this.index,
      required this.game,
      required this.resourceManager})
      : super(key: key);
  final int index;
  final ResourceManager resourceManager;
  final Game game;
  @override
  State<HomePageGameTile> createState() => _HomePageGameTileState();
}

class _HomePageGameTileState extends State<HomePageGameTile> {
  @override
  Widget build(BuildContext context) {
    Image image = Image.network(
      ResourceManager.getPictureWithResolution(widget.game.cover!.url, '720p'),
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
                    tag: "cover${widget.game.cover!.url}",
                    child: Image.network(
                      ResourceManager.getPictureWithResolution(
                          widget.game.cover!.url, '720p'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                            gameID: widget.game.id!,
                            resMan: widget.resourceManager),
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
                                  message: widget.game.name,
                                  waitDuration: const Duration(seconds: 1),
                                  showDuration:
                                      const Duration(milliseconds: 100),
                                  preferBelow: false,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    widget.game.name!,
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
                                  Text((widget.game.rating! / 20.0)
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
// return SizedBox(
//       width: image.width,
//       height: image.height,
//       child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Stack(
//               children: [
//                 GestureDetector(
//                   child: Hero(
//                     tag: "cover${widget.index}",
//                     child: image,
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DetailsPage(
//                             game: widget.game,
//                             resMan: widget.resourceManager,
//                             index: widget.index),
//                       ),
//                     );
//                   },
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   height: 30,
//                   child: SizedBox(
//                       width: image.width,
//                       height: 30,
//                       child: Container(
//                           decoration: const BoxDecoration(
//                               gradient: LinearGradient(
//                                   begin: Alignment(0, -0.7),
//                                   end: Alignment(0, 0.9),
//                                   colors: [
//                             Color.fromARGB(0, 0, 0, 0),
//                             Colors.black
//                           ])))),
//                 ),
//                 Positioned(
//                     bottom: 0,
//                     child: SizedBox(
//                       width: image.width,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 7.0),
//                         child: DefaultTextStyle(
//                           style: const TextStyle(color: Colors.white),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Flexible(
//                                 child: Tooltip(
//                                   message: widget.game.name,
//                                   waitDuration: const Duration(seconds: 1),
//                                   showDuration:
//                                       const Duration(milliseconds: 100),
//                                   preferBelow: false,
//                                   decoration: BoxDecoration(
//                                     color: Colors.black,
//                                     borderRadius: BorderRadius.circular(6),
//                                   ),
//                                   child: Text(
//                                     widget.game.name,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   Transform.scale(
//                                     scale: 0.75,
//                                     child: const Icon(
//                                       Icons.star,
//                                       color: Colors.yellow,
//                                     ),
//                                   ),
//                                   Text((widget.game.rating / 20.0)
//                                       .toStringAsPrecision(3))
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ))
//               ],
//             ),
//           )),
//     );