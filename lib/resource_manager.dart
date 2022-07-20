import 'package:game_lib_app/constants.dart';
import 'package:game_lib_app/credentials.dart';
import 'package:game_lib_app/game/game.dart';
import 'package:game_lib_app/network_manager.dart';
import 'dart:convert';

import 'package:http/http.dart';

class ResourceManager {
  List<Game> homePageGamesLoaded;
  NetworkManager netMan = NetworkManager(baseUrl: 'api.igdb.com');

  ResourceManager() : homePageGamesLoaded = [];

  Game getGame(int index) {
    return homePageGamesLoaded[index];
  }

  List<Game> getLoadedGames() {
    return homePageGamesLoaded;
  }

  static String getResolution(String link, String resolution_name) {
    return 'https:${link.replaceAll(RegExp('thumb'), resolution_name)}';
  }

  Future<int> loadMoreGames(int count) async {
    const JsonDecoder decoder = JsonDecoder();
    Response response = await netMan.sendRequest(
        'v4/games',
        {'Client-ID': clientID, 'Authorization': auth},
        "fields *, cover.url,genres.name,collection.name,dlcs.name,expansions.name,parent_game.name,franchises.name,screenshots.url,involved_companies.company.name,platforms.name,game_modes.name; where cover !=null&rating !=null; limit $pagesToLoad; offset $count;sort rating desc;");
    var respolseLookUp = response.body;
    List<Game> tempList = List<Game>.from(
        decoder.convert(response.body).map((game) => Game.fromJson(game)));

    homePageGamesLoaded.addAll(tempList);
    return tempList.length;
  }
}
