import 'package:bloc/bloc.dart';
import 'package:game_lib_app/game/game.dart';

part 'fav_games_state.dart';

class FavGamesCubit extends Cubit<FavGamesState> {
  FavGamesCubit() : super(FavGamesState([]));
  void addGame(Game game) {
    state.list.add(game);
    List<Game> temp = state.list;
    emit(FavGamesState(temp));
  }

  void removeGame(int id) {
    for (Game favGame in state.list) {
      if (id == favGame.id) {
        state.list.remove(favGame);
        List<Game> temp = state.list;
        emit(FavGamesState(temp));
        break;
      }
    }
  }
}
