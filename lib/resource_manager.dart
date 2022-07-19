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

  Future<int> loadMoreGames(int count) async {
    const JsonDecoder decoder = JsonDecoder();
    Response response = await netMan.sendRequest(
        'v4/games',
        {'Client-ID': clientID, 'Authorization': auth},
        "fields name, summary, cover.url,genres.name,rating; where cover !=null&rating >90; limit $pagesToLoad; offset $count;");
    var respolseLookUp = response.body;
    List<Game> tempList = List<Game>.from(
        decoder.convert(response.body).map((game) => Game.fromJson(game)));

    homePageGamesLoaded.addAll(tempList);
    return tempList.length;
  }
}
