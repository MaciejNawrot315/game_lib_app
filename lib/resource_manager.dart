import 'package:game_lib_app/constants.dart';
import 'package:game_lib_app/credentials.dart';
import 'package:game_lib_app/game/field_with_name.dart';
import 'package:game_lib_app/game/game.dart';
import 'package:game_lib_app/game/genre.dart';
import 'package:game_lib_app/network_manager.dart';
import 'package:game_lib_app/search_page/search_response/search_response.dart';
import 'dart:convert';

import 'package:http/http.dart';

class ResourceManager {
  List<Game> homePageGamesLoaded;
  List<SearchResponse> searchResponses;
  List<Genre> genresLoaded;
  NetworkManager netMan = NetworkManager(baseUrl: 'api.igdb.com');

  ResourceManager()
      : homePageGamesLoaded = [],
        searchResponses = [],
        genresLoaded = [];

  Game getGame(int index) {
    return homePageGamesLoaded[index];
  }

  List<Game> getLoadedGames() {
    return homePageGamesLoaded;
  }

  static String getPictureWithResolution(String link, String resolutionName) {
    return 'https:${link.replaceAll(RegExp('thumb'), resolutionName)}';
  }

  Future<int> loadMoreGames(int count, String whereFilters) async {
    const JsonDecoder decoder = JsonDecoder();
    Response response = await netMan.sendRequest(
        'v4/games',
        {'Client-ID': clientID, 'Authorization': auth},
        "fields name,rating, cover.url,genres.*; where cover !=null&rating !=null$whereFilters; limit $pagesToLoad; offset $count;sort rating desc;");
    var respolseLookUp = response.body;
    List<Game> tempList = List<Game>.from(
        decoder.convert(response.body).map((game) => Game.fromJson(game)));

    homePageGamesLoaded.addAll(tempList);
    return tempList.length;
  }

  Future<int> searchForPhrases(String phrase) async {
    searchResponses = [];
    const JsonDecoder decoder = JsonDecoder();
    Response response = await netMan.sendRequest(
        'v4/search',
        {'Client-ID': clientID, 'Authorization': auth},
        "fields *, game.cover.url, game.rating ;search \"$phrase\";where game.cover.url!=null;limit: 30;");
    var respolseLookUp = response.body;
    List<SearchResponse> tempList = List<SearchResponse>.from(decoder
        .convert(response.body)
        .map((response) => SearchResponse.fromJson(response)));

    searchResponses.addAll(tempList);
    return tempList.length;
  }

  Future<Game> fetchGame(int id) async {
    const JsonDecoder decoder = JsonDecoder();
    Response response = await netMan.sendRequest(
        'v4/games',
        {'Client-ID': clientID, 'Authorization': auth},
        "fields *,cover.url,genres.name,collection.name,dlcs.name,expansions.name,parent_game.name,franchises.name,screenshots.url,involved_companies.company.name,platforms.name,game_modes.name;where id=$id;");
    var respolseLookUp = response.body;
    List<Game> tempList = List<Game>.from(
        decoder.convert(response.body).map((game) => Game.fromJson(game)));

    return tempList[0];
  }

  Future<int> loadGenres(int count) async {
    const JsonDecoder decoder = JsonDecoder();
    Response response = await netMan.sendRequest(
        'v4/genres',
        {'Client-ID': clientID, 'Authorization': auth},
        "fields name; limit 30; offset $count;");
    var respolseLookUp = response.body;
    List<Genre> tempList = List<Genre>.from(
        decoder.convert(response.body).map((game) => Genre.fromJson(game)));

    genresLoaded.addAll(tempList);
    return tempList.length;
  }
}
