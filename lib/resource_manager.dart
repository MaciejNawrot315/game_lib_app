import 'dart:collection';
import 'dart:io';

import 'package:game_lib_app/credentials.dart';
import 'package:game_lib_app/game.dart';
import 'package:game_lib_app/network_manager.dart';
import 'dart:convert';

import 'package:http/http.dart';

class ResourceManager {
  List<Game> homePageGamesLoaded;
  List<dynamic> homePageGameCovers;
  NetworkManager netMan = NetworkManager(baseUrl: 'api.igdb.com');

  ResourceManager()
      : homePageGamesLoaded = [],
        homePageGameCovers = [];
  Future<Game> getTileData(int index) async {
    var length = homePageGamesLoaded.length;
    if (index > length + 9) {
      return Game(); //TODO throw an exception
    }
    if (index >= length) {
      const JsonDecoder decoder = JsonDecoder();
      Response response = await netMan.sendRequest(
          'v4/games',
          {
            'Client-ID': 'pvo0zbv2nusp4sk6zy34oro2rvl0ve',
            'Authorization': "Bearer xa35gn2632o7nsnxb1nlfybtnn7zwj"
          },
          "fields *; where cover !=null&rating >99;");
      List<Game> tempList = List<Game>.from(
          decoder.convert(response.body).map((game) => Game.fromJson(game)));

      homePageGamesLoaded.addAll(tempList);
    }

    return homePageGamesLoaded[index];
  }

  int calculateRange(int number) {
    return ((number / 10).floor()) * 10;
  }

  Future<String> getCoverPic(int index) async {
    var length = homePageGameCovers.length;
    //TODO throw exception when index > length + 9
    if (index >= length) {
      const JsonDecoder decoder = JsonDecoder();
      int base = calculateRange(index);
      List<int> coverIds = [];
      for (int i = 0; i < 10; i++) {
        coverIds.add(homePageGamesLoaded[base + i].cover!);
      }
      String temp2 = coverIds.join(",");
      String where = 'where id = ($temp2);';
      Response response;
      while (true) {
        response = await netMan.sendRequest(
            'v4/covers',
            {'Client-ID': clientID, 'Authorization': auth},
            "fields url; $where");
        if (response.statusCode == 429) {
          //review
          sleep(const Duration(milliseconds: 1000));
          continue;
        }
        break;
      }
      List<dynamic> tempList = json
          .decode(response.body)
          .map<HashMap<String, dynamic>>(
              (e) => HashMap<String, dynamic>.from(e))
          .toList();

      for (int i = 0; i < 10; i++) {
        //sorting the responses form the covers
        for (int j = i; j < 10; j++) {
          if (coverIds[i] == tempList[j]['id']) {
            Map<String, dynamic> temp = tempList[i];
            tempList[i] = tempList[j];
            tempList[j] = temp;
            break;
          }
        }
        homePageGamesLoaded[base + i].coverUrl = "https:${tempList[i]['url']}";
      }
    }

    return homePageGamesLoaded[index].coverUrl!;
  }
}
