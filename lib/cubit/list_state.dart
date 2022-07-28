import 'package:game_lib_app/game/game.dart';

abstract class ListState {
  List<Game> list;
  ListState(this.list);
}
