import 'package:bloc/bloc.dart';

import 'package:game_lib_app/models/game/game.dart';

class GamesCubit extends Cubit<List<Game>> {
  GamesCubit() : super([]);
  void addGame(Game game) {
    List<Game> temp = state.toList();
    temp.firstWhere((elemGame) => elemGame.id == game.id, orElse: () {
      temp.add(game);
      emit(temp);
      return game;
    });
  }

  void removeGame(int id) {
    List<Game> temp = state.toList();
    temp.removeWhere((game) => game.id == id);
    emit(temp);
  }
}

class FavGamesCubit extends GamesCubit {}

class PlayedGamesCubit extends GamesCubit {}

class WishlistGamesCubit extends GamesCubit {}
