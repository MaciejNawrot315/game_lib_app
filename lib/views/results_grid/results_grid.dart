import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:game_lib_app/constants.dart';

import 'package:game_lib_app/models/game/game.dart';
import 'package:game_lib_app/models/game/game_list_model.dart';
import 'package:game_lib_app/repositories/igdb_repository.dart';
import 'package:game_lib_app/widgets/injector.dart';
import 'package:get/get.dart';

import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'results_grid_game_tile.dart';

class ResultsGrid extends StatefulWidget {
  final String whereFilters;
  const ResultsGrid({
    Key? key,
    this.whereFilters = '',
  }) : super(key: key);

  @override
  State<ResultsGrid> createState() => _ResultsGridState();
}

class _ResultsGridState extends State<ResultsGrid> {
  bool gamesLoading = false;
  int count = 0;
  bool isEnd = false;
  bool firstBuild = true;
  List<Game> loadedGames = [];
  Future<void> loadMoreGames() async {
    if (mounted) {
      setState(() {
        gamesLoading = true;
      });
    }
    List<Game> temp =
        await IgdbRepository.fetchGamePosters(widget.whereFilters, count);
    if (temp.length < pagesToLoad) {
      isEnd = true;
    }
    loadedGames += temp;

    gamesLoading = false;

    count = loadedGames.length;
    if (mounted) {
      setState(() {});
    }
    firstBuild = false;
  }

  @override
  void initState() {
    super.initState();
    if (widget.whereFilters == '') {
      loadedGames = locator.get<GameListModel>().list;
      count = loadedGames.length;
    } else {
      loadMoreGames();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: LazyLoadScrollView(
        scrollOffset: 600,
        isLoading: gamesLoading,
        onEndOfPage: () => loadMoreGames(),
        child: MasonryGridView.count(
            crossAxisCount: 2,
            itemCount: count + 1,
            itemBuilder: (BuildContext context, index) {
              if (index >= count) {
                if (isEnd) {
                  return Text(
                    'no_more_results'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[300]),
                  );
                }

                return firstBuild
                    ? const SizedBox()
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              }
              return ResultsGameTile(
                index: index,
                game: loadedGames[index],
              );
            }),
      ),
    );
  }
}
