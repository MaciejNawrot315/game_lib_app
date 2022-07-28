import 'package:game_lib_app/models/game/game.dart';

abstract class ListState {
  List<Game> list;
  ListState(this.list);
  bool contains(int id) {
    for (Game game in list) {
      if (game.id == id) {
        return true;
      }
    }
    return false;
  }
}
