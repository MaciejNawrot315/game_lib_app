import 'package:flutter/material.dart';
import 'package:game_lib_app/details_page/details_image.dart';
import 'package:game_lib_app/details_page/screenshot_galery.dart';
import 'package:game_lib_app/game/game.dart';
import 'package:game_lib_app/game/involved_company.dart';
import 'package:game_lib_app/game/field_with_name.dart';
import 'package:game_lib_app/repositories/igdb_repository.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';

import 'single_details_item.dart';

class DetailsPage extends StatefulWidget {
  final int gameID;

  const DetailsPage({
    Key? key,
    required this.gameID,
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
    return IgdbRepository.fetchGame(widget.gameID);
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

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DetailsImage(
                        url: game.cover!.url,
                        name: game.name!,
                        rating: game.rating,
                        ratingCount: game.rating_count),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${'summary'.tr}:"),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(game.summary ?? ""),
                    ),
                    const Divider(),
                    SingleDetailsLineIfExists(
                      item: 'release_date'.tr,
                      value: dateFormat.format(
                          DateTime.fromMillisecondsSinceEpoch(
                              (game.first_release_date ?? 0) * 1000)),
                    ),
                    SingleDetailsLineIfExists(
                      item: 'genres'.tr,
                      value: getNamesString(game.genres ?? <FieldWithName>[]),
                    ),
                    SingleDetailsLineIfExists(
                      item: 'game_modes'.tr,
                      value:
                          getNamesString(game.game_modes ?? <FieldWithName>[]),
                    ),
                    SingleDetailsLineIfExists(
                      item: "part_of".tr,
                      value: game.collection?.name ?? "",
                    ),
                    SingleDetailsLineIfExists(
                      item: "from the franchise",
                      value:
                          getNamesString(game.franchises ?? <FieldWithName>[]),
                    ),
                    SingleDetailsLineIfExists(
                      item: "companies".tr,
                      value: getCompaniesNamesString(
                          game.involved_companies ?? <InvolvedCompany>[]),
                    ),
                    SingleDetailsLineIfExists(
                      item: "available_on".tr,
                      value:
                          getNamesString(game.platforms ?? <FieldWithName>[]),
                    ),
                    SingleDetailsLineIfExists(
                      item: "main_game".tr,
                      value: game.parent_game?.name ?? "",
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 30, 0, 0),
                      child: Text("${"screenshots".tr}:",
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 12)),
                    ),
                    ScreenshotGalery(screenshots: game.screenshots)
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
        ),
      ),
    );
  }
}
