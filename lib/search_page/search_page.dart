import 'package:flutter/material.dart';
import 'package:game_lib_app/game/genre.dart';
import 'package:game_lib_app/repositories/igdb_repository.dart';

import 'package:game_lib_app/search_page/genres_grid_page.dart';
import 'package:game_lib_app/search_page/searching_view.dart';
import 'dart:math' as math;

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int listLength = 0;
  List<Genre> loadedGenres = [];
  Future<void> loadGenres() async {
    loadedGenres = await IgdbRepository.fetchGenres(listLength);
    if (mounted) {
      setState(() {
        listLength = loadedGenres.length;
      });
    }
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
                            pageBuilder: (_, __, ___) => const SearchingView(),
                            transitionsBuilder: (_, anim, __, child) =>
                                FadeTransition(opacity: anim, child: child),
                            transitionDuration:
                                const Duration(milliseconds: 15),
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
                                  "&genres = ${loadedGenres[index].id}",
                            ),
                          ),
                        ),
                        child: Container(
                          color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(1.0),
                          child: Center(
                              child: Text(
                            loadedGenres[index].name ?? "",
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
