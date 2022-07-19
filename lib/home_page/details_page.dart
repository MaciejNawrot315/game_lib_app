import 'package:flutter/material.dart';
import 'package:game_lib_app/game/game.dart';
import 'package:game_lib_app/resource_manager.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(
      {Key? key, required this.game, required this.resMan, required this.index})
      : super(key: key);
  final Game game;
  final ResourceManager resMan;
  final int index;
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Hero(
                  tag: "cover${widget.index}",
                  child: Image.network(
                    'https:${widget.game.cover.url}',
                    fit: BoxFit.fitWidth,
                    height: MediaQuery.of(context).size.width,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0, -0.7),
                          end: Alignment(0, 0.9),
                          colors: [Color.fromARGB(0, 0, 0, 0), Colors.black],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DefaultTextStyle(
                    style: const TextStyle(color: Colors.white),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(widget.game.name,
                                  style: const TextStyle(fontSize: 30),
                                  overflow: TextOverflow.clip),
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 1.5,
                                  child: const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    10,
                                    0,
                                    0,
                                    0,
                                  ),
                                  child: Text(
                                    (widget.game.rating / 20.0)
                                        .toStringAsPrecision(3),
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Summary:"),
                  )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(widget.game.summary!),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
