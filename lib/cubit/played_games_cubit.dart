import 'package:bloc/bloc.dart';
import 'package:game_lib_app/cubit/list_state.dart';
import 'package:game_lib_app/game/game.dart';

part 'played_games_state.dart';

class PlayedGamesCubit extends Cubit<PlayedGamesState> {
  PlayedGamesCubit() : super(PlayedGamesState([]));
  void addGame(Game game) {
    state.list.add(game);
    List<Game> temp = state.list;
    emit(PlayedGamesState(temp));
  }

  void removeGame(int id) {
    for (Game favGame in state.list) {
      if (id == favGame.id) {
        state.list.remove(favGame);
        List<Game> temp = state.list;
        emit(PlayedGamesState(temp));
        break;
      }
    }
  }
}
