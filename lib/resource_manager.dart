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
    var length = homePageGamesLoaded.length;
    if (index > length + 9) {
      throw Exception();
    }
    if (index >= length) {
      loadMoreGames((index / 10).floor());
    }
    return homePageGamesLoaded[index];
  }

  List<Game> getLoadedGames() {
    return homePageGamesLoaded;
  }

  Future<bool> loadMoreGames(int count) async {
    const JsonDecoder decoder = JsonDecoder();
    Response response = await netMan.sendRequest(
        'v4/games',
        {'Client-ID': clientID, 'Authorization': auth},
        "fields name, summary, cover.url,genres.name,rating; where cover !=null&rating >99;limit $pagesToLoad;offset ${pagesToLoad * count}");
    List<Game> tempList = List<Game>.from(
        decoder.convert(response.body).map((game) => Game.fromJson(game)));

    homePageGamesLoaded.addAll(tempList);
    return true;
  }
}
