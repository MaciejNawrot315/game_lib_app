import 'package:dio/dio.dart';
import 'package:game_lib_app/constants.dart';
import 'package:game_lib_app/main.dart';

class IGDBNetworkService {
  static Future<Response> fetchGamePosters(
      String whereFilters, int count) async {
    Response response = await networkService.post('v4/games',
        "fields name,rating, cover.url,genres.*; where cover !=null&rating !=null$whereFilters; limit $pagesToLoad; offset $count;sort rating desc;");

    return response;
  }

  static Future<Response> searchForPhrases(String phrase, int offset) async {
    Response response = await networkService.post('v4/search',
        "fields *, game.cover.url, game.rating ;search \"$phrase\";where game.cover.url!=null;limit 30;offset $offset;");

    return response;
  }

  static Future<Response> fetchGame(int id) async {
    Response response = await networkService.post('v4/games',
        "fields *,cover.url,genres.name,collection.name,dlcs.name,expansions.name,parent_game.name,franchises.name,screenshots.url,involved_companies.company.name,platforms.name,game_modes.name;where id=$id;");

    return response;
  }

  static Future<Response> fetchGenres() async {
    Response response =
        await networkService.post('v4/genres', "fields name; limit 30;");

    return response;
  }
}
