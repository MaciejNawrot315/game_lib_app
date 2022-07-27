import 'package:dio/dio.dart';
import 'package:game_lib_app/game/game.dart';
import 'package:game_lib_app/game/genre.dart';
import 'package:game_lib_app/search_page/search_response/search_response.dart';
import 'package:game_lib_app/services/igdb_network_services.dart';

class IgdbRepository {
  static Future<List<Game>> fetchGamePosters(
      String whereFilters, int offset) async {
    try {
      Response response =
          await IGDBNetworkService.fetchGamePosters(whereFilters, offset);

      return List<Game>.from(response.data.map((game) => Game.fromJson(game)));
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<SearchResponse>> searchForPhrases(
      String phrase, int offset) async {
    Response response =
        await IGDBNetworkService.searchForPhrases(phrase, offset);
    return List<SearchResponse>.from(
        response.data.map((response) => SearchResponse.fromJson(response)));
  }

  static Future<Game> fetchGame(int id) async {
    Response response = await IGDBNetworkService.fetchGame(id);

    return List<Game>.from(response.data.map((game) => Game.fromJson(game)))[0];
  }

  static Future<List<Genre>> fetchGenres(int count) async {
    Response response = await IGDBNetworkService.fetchGenres();

    return List<Genre>.from(response.data.map((game) => Genre.fromJson(game)));
  }

  static String getPictureWithResolution(String link, String resolutionName) {
    return 'https:${link.replaceAll(RegExp('thumb'), resolutionName)}';
  }
}
