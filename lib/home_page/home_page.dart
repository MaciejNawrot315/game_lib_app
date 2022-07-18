import 'package:flutter/material.dart';
import 'package:game_lib_app/resource_manager.dart';

import 'home_page_game_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ResourceManager resMan = ResourceManager();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, index) {
            return HomePageGameTile(
              index: index,
              resourceManager: resMan,
            );
          }),
    );
  }
}
