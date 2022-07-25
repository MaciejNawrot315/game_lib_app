import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:game_lib_app/resource_manager.dart';
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
  ResourceManager resMan = ResourceManager();
  bool gamesLoading = false;
  int count = 0;
  Future<void> loadMoreGames() async {
    if (mounted) {
      setState(() {
        gamesLoading = true;
      });
    }

    await resMan.loadMoreGames(count, widget.whereFilters);
    count = resMan.resaultsGamesLoaded.length;
    if (mounted) {
      setState(() {
        gamesLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadMoreGames();
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ResultsGameTile(
                index: index,
                resourceManager: resMan,
              );
            }),
      ),
    );
  }
}
