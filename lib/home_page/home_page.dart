import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:game_lib_app/resource_manager.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'package:game_lib_app/constants.dart';
import 'home_page_game_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ResourceManager resMan = ResourceManager();
  bool gamesLoading = false;
  int count = 0;
  Future loadMoreGames() async {
    setState(() {
      gamesLoading = true;
    });

    count += await resMan.loadMoreGames(count);
    setState(() {
      gamesLoading = false;
    });
  }

  @override
  void initState() {
    loadMoreGames();
    super.initState();
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
