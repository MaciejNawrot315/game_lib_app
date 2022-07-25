import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:game_lib_app/game/field_with_name.dart';
import 'package:game_lib_app/results_grid/results_grid.dart';
import 'package:game_lib_app/resource_manager.dart';
import 'package:game_lib_app/search_page/genres_grid_page.dart';
import 'package:game_lib_app/search_page/searching_view.dart';
import 'dart:math' as math;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ResourceManager resMan = ResourceManager();
  int listLength = 0;
  Future<void> loadGenres() async {
    int length = await resMan.loadGenres(listLength);

    setState(() {
      listLength += length;
    });
  }

  @override
  void initState() {
    loadGenres();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => SearchingView(),
                            transitionsBuilder: (c, anim, a2, child) =>
                                FadeTransition(opacity: anim, child: child),
                            transitionDuration: Duration(milliseconds: 15),
                          ),
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.search_rounded),
                        Text("Search for your favourite games"),
                      ],
                    )),
              ),
            ),
          ),
          GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 4 / 3),
              itemCount: listLength,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: GridTile(
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GenresGridPage(
                              whereFilters:
                                  "&genres = ${resMan.genresLoaded[index].id}",
                            ),
                          ),
                        ),
                        child: Container(
                          color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(1.0),
                          child: Center(
                              child: Text(
                            resMan.genresLoaded[index].name ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
