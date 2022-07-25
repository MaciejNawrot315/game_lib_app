import 'package:flutter/material.dart';
import 'package:game_lib_app/game/game.dart';
import 'package:game_lib_app/game/involved_company.dart';
import 'package:game_lib_app/game/field_with_name.dart';
import 'package:game_lib_app/resource_manager.dart';
import 'package:intl/intl.dart';

import 'single_details_item.dart';

class DetailsPage extends StatefulWidget {
  final int gameID;
  final ResourceManager resMan;

  const DetailsPage({
    Key? key,
    required this.gameID,
    required this.resMan,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  String getNamesString(List<FieldWithName> list) {
    String output = '';
    if (list.isEmpty) {
      return output;
    }
    for (FieldWithName nameClass in list) {
      output += '${nameClass.name} / ';
    }
    output = output.substring(0, output.length - 2);
    return output;
  }

  String getCompaniesNamesString(List<InvolvedCompany> list) {
    if (list.isEmpty) {
      return '';
    }
    List<FieldWithName> namesList = [];
    for (InvolvedCompany company in list) {
      namesList.add(company.company!);
    }

    return getNamesString(namesList);
  }

  Future<Game> fetchGame() {
    return widget.resMan.fetchGame(widget.gameID);
  }

  void openScreenchot() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          color: Colors.grey[300],
          child: FutureBuilder<Game>(
            future: fetchGame(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Game game = snapshot.data!;
                int screenshotsAmount = game.screenshots?.length ?? 0;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(children: [
                        Hero(
                          tag: "cover${game.cover!.url}",
                          child: Image.network(
                            ResourceManager.getPictureWithResolution(
                                game.cover!.url, '720p'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0, -0.7),
                                  end: Alignment(0, 0.9),
                                  colors: [
                                    Color.fromARGB(0, 0, 0, 0),
                                    Colors.black
                                  ],
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(game.name!,
                                            style:
                                                const TextStyle(fontSize: 30),
                                            overflow: TextOverflow.clip),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                ),
                                                child: Text(
                                                  ((game.rating ?? 0) / 20.0)
                                                      .toStringAsPrecision(3),
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 7),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.person,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                ),
                                                child: Text(
                                                  (game.rating_count ?? 0)
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        )
                      ]),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Summary:"),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(game.summary ?? ""),
                      ),
                      const Divider(),
                      SingleDetailsLineIfExists(
                        item: "release date",
                        value: dateFormat.format(
                            DateTime.fromMillisecondsSinceEpoch(
                                (game.first_release_date ?? 0) * 1000)),
                      ),
                      SingleDetailsLineIfExists(
                        item: "genres",
                        value: getNamesString(game.genres ?? <FieldWithName>[]),
                      ),
                      SingleDetailsLineIfExists(
                        item: "game modes",
                        value: getNamesString(
                            game.game_modes ?? <FieldWithName>[]),
                      ),
                      SingleDetailsLineIfExists(
                        item: "part of the series",
                        value: game.collection?.name ?? "",
                      ),
                      SingleDetailsLineIfExists(
                        item: "from the franchise",
                        value: getNamesString(
                            game.franchises ?? <FieldWithName>[]),
                      ),
                      SingleDetailsLineIfExists(
                        item: "companies",
                        value: getCompaniesNamesString(
                            game.involved_companies ?? <InvolvedCompany>[]),
                      ),
                      SingleDetailsLineIfExists(
                        item: "available on",
                        value:
                            getNamesString(game.platforms ?? <FieldWithName>[]),
                      ),
                      SingleDetailsLineIfExists(
                        item: "part of the main game",
                        value: game.parent_game?.name ?? "",
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 30, 0, 0),
                        child: Text("ingame screenshots:",
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 12)),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: screenshotsAmount,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GestureDetector(
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      Dismissible(
                                    direction: DismissDirection.down,
                                    key: const Key('key'),
                                    onDismissed: (_) =>
                                        Navigator.of(context).pop(),
                                    child: Dialog(
                                      insetPadding: EdgeInsets.zero,
                                      child: Image.network(
                                          ResourceManager
                                              .getPictureWithResolution(
                                                  game.screenshots![index].url!,
                                                  '720p'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    ResourceManager.getPictureWithResolution(
                                        game.screenshots![index].url!, '720p'),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
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
              return const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }
}
