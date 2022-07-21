import 'package:flutter/material.dart';
import 'package:game_lib_app/game/game.dart';
import 'package:game_lib_app/game/involved_company.dart';
import 'package:game_lib_app/game/field_with_name.dart';
import 'package:game_lib_app/resource_manager.dart';
import 'package:intl/intl.dart';

import 'details_item.dart';

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
  final dateFormat = DateFormat('dd-MM-yyyy');

  String getNamesString(List<FieldWithName> list) {
    String output = '';
    if (list.isEmpty) {
      return output;
    }
    for (FieldWithName nameClass in list) {
      output = '$output${nameClass.name} / ';
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

  @override
  Widget build(BuildContext context) {
    int screenshotsAmount = widget.game.screenshots?.length ?? 0;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(children: [
                Hero(
                  tag: "cover${widget.game.cover!.url}",
                  child: Image.network(
                    ResourceManager.getPictureWithResolution(
                        widget.game.cover!.url, '720p'),
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
                              child: Text(widget.game.name!,
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
                                    (widget.game.rating! / 20.0)
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
                child: Text(widget.game.summary ?? ""),
              ),
              const Divider(),
              DetailsItemIfExists(
                item: "release date",
                value: dateFormat.format(DateTime.fromMillisecondsSinceEpoch(
                    (widget.game.first_release_date ?? 0) * 1000)),
              ),
              widget.game.genres != null
                  ? DetailsItemIfExists(
                      item: "genres",
                      value: getNamesString(
                          widget.game.genres ?? <FieldWithName>[]),
                    )
                  : Container(),
              DetailsItemIfExists(
                item: "game modes",
                value:
                    getNamesString(widget.game.game_modes ?? <FieldWithName>[]),
              ),
              DetailsItemIfExists(
                item: "part of the series",
                value: widget.game.collection?.name ?? "",
              ),
              DetailsItemIfExists(
                item: "from the franchise",
                value:
                    getNamesString(widget.game.franchises ?? <FieldWithName>[]),
              ),
              DetailsItemIfExists(
                item: "companies",
                value: getCompaniesNamesString(
                    widget.game.involved_companies ?? <InvolvedCompany>[]),
              ),
              DetailsItemIfExists(
                item: "available on",
                value:
                    getNamesString(widget.game.platforms ?? <FieldWithName>[]),
              ),
              DetailsItemIfExists(
                item: "part of the main game",
                value: widget.game.parent_game?.name ?? "",
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 30, 0, 0),
                child: Text("ingame screenshots:",
                    style: TextStyle(color: Colors.grey[700], fontSize: 12)),
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
                          builder: (BuildContext context) => Dismissible(
                            direction: DismissDirection.down,
                            key: const Key('key'),
                            onDismissed: (_) => Navigator.of(context).pop(),
                            child: Dialog(
                              insetPadding: EdgeInsets.zero,
                              child: Image.network(
                                  ResourceManager.getPictureWithResolution(
                                      widget.game.screenshots![index].url!,
                                      '720p'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            ResourceManager.getPictureWithResolution(
                                widget.game.screenshots![index].url!, '720p'),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
