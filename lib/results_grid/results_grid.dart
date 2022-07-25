import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:game_lib_app/resource_manager.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

<<<<<<< HEAD:lib/results_grid/results_grid.dart
import 'package:game_lib_app/constants.dart';
import 'results_grid_game_tile.dart';
=======
import 'home_page_game_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
>>>>>>> dev:lib/home_page/home_page.dart

class ResultsGrid extends StatefulWidget {
  const ResultsGrid({Key? key, this.whereFilters = ''}) : super(key: key);
  final String whereFilters;
  @override
  State<ResultsGrid> createState() => _ResultsGridState();
}

class _ResultsGridState extends State<ResultsGrid> {
  ResourceManager resMan = ResourceManager();
  bool gamesLoading = false;
  int count = 0;
  Future loadMoreGames() async {
    if (mounted) {
      setState(() {
        gamesLoading = true;
      });
    }

    count += await resMan.loadMoreGames(count, widget.whereFilters);
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
              return HomePageGameTile(
                game: resMan.getGame(index),
                index: index,
                resourceManager: resMan,
              );
            }),
      ),
    );
  }
}
