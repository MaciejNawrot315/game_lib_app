import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/cubit/fav_games_cubit.dart';
import 'package:game_lib_app/cubit/played_games_cubit.dart';
import 'package:game_lib_app/cubit/wishlist_games_cubit.dart';
import 'package:game_lib_app/details_page/details_image.dart';

import 'package:game_lib_app/details_page/screenshot_galery.dart';
import 'package:game_lib_app/game/game.dart';
import 'package:game_lib_app/game/involved_company.dart';
import 'package:game_lib_app/game/field_with_name.dart';
import 'package:game_lib_app/repositories/igdb_repository.dart';
import 'package:game_lib_app/widgets/favourite_game_dialog.dart';
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

  bool isFavourite(BuildContext context, int id) {
    for (Game favGame in context.read<FavGamesCubit>().state.list) {
      if (favGame.id == id) {
        return true;
      }
    }
    return false;
  }

  bool isInPlayed(BuildContext context, int id) {
    for (Game playedGame in context.read<PlayedGamesCubit>().state.list) {
      if (playedGame.id == id) {
        return true;
      }
    }
    return false;
  }

  bool isInWishlist(BuildContext context, int id) {
    for (Game wishlistGame in context.read<WishlistGamesCubit>().state.list) {
      if (wishlistGame.id == id) {
        return true;
      }
    }
    return false;
  }

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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("${'summary'.tr}:"),
                          ),
                          Builder(
                            builder: (context) {
                              final stateFav =
                                  context.watch<FavGamesCubit>().state;
                              final statePlayed =
                                  context.watch<PlayedGamesCubit>().state;
                              final stateWishlist =
                                  context.watch<WishlistGamesCubit>().state;
                              return GestureDetector(
                                onLongPress: () => showDialog(
                                  context: context,
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<FavGamesCubit>(),
                                    child: BlocProvider.value(
                                      value: context.read<PlayedGamesCubit>(),
                                      child: BlocProvider.value(
                                        value:
                                            context.read<WishlistGamesCubit>(),
                                        child: FavDialog(
                                          game: game,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                child: isFavourite(context, game.id)
                                    ? IconButton(
                                        onPressed: () {
                                          context
                                              .read<FavGamesCubit>()
                                              .removeGame(game.id);
                                        },
                                        icon: const Icon(
                                          Icons.favorite_rounded,
                                          color: Colors.pink,
                                        ))
                                    : IconButton(
                                        onPressed: () {
                                          context
                                              .read<FavGamesCubit>()
                                              .addGame(game);
                                        },
                                        icon: const Icon(
                                          Icons.favorite_border_rounded,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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
