import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:game_lib_app/home_page/details_page.dart';
import 'package:game_lib_app/resource_manager.dart';

import 'package:game_lib_app/game.dart';

class HomePageGameTile extends StatefulWidget {
  HomePageGameTile(
      {Key? key, required this.index, required this.resourceManager})
      : super(key: key);
  final int index;
  final ResourceManager resourceManager;

  @override
  State<HomePageGameTile> createState() => _HomePageGameTileState();
}

class _HomePageGameTileState extends State<HomePageGameTile> {
  late Future<Game> tileData = widget.resourceManager.getTileData(widget
      .index); //review gdzie powinienem to zdefiniowac? mozliwe ze i tak po poznaniu bloc future buildery znikną

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: LayoutBuilder(builder: (context, constraints) {
          return FutureBuilder<Game>(
            future: tileData,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                Future<String> cover =
                    widget.resourceManager.getCoverPic(widget.index);
                return Stack(
                  children: [
                    FutureBuilder<String>(
                      future: cover,
                      builder: ((context, snapshot2) {
                        if (snapshot2.hasData) {
                          return GestureDetector(
                            child: Hero(
                              tag: "cover${widget.index}",
                              child: Image.network(snapshot2.data!,
                                  fit: BoxFit.fitWidth,
                                  height: constraints.maxWidth),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                      game: snapshot.data!,
                                      resMan: widget.resourceManager,
                                      index: widget.index),
                                ),
                              );
                            },
                          );
                        } else if (snapshot2.hasError) {
                          return Center(
                            child: Column(
                              children: [
                                const Icon(Icons.error_outline,
                                    color: Colors.red),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Text('Error: ${snapshot.error}'),
                                ),
                              ],
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          ),
                        );
                      }),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 7.0),
                            child: DefaultTextStyle(
                              style: TextStyle(color: Colors.white),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                    child: Tooltip(
                                      message: snapshot.data!.name,
                                      waitDuration: const Duration(seconds: 1),
                                      showDuration:
                                          const Duration(milliseconds: 100),
                                      preferBelow: false,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        snapshot.data!.name!,
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
                                      Text((snapshot.data!.rating! / 20.0)
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
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      ),
                    ],
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
          );
        }),
      ),
    );
  }
}
