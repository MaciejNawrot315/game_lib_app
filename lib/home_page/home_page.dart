import 'package:flutter/material.dart';
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
    count += 1;
    bool worked = await resMan.loadMoreGames(count);

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
        isLoading: gamesLoading,
        onEndOfPage: () => loadMoreGames(),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: pagesToLoad * count,
            itemBuilder: (BuildContext context, index) {
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
