import 'package:bloc/bloc.dart';
import 'package:game_lib_app/cubit/list_state.dart';
import 'package:game_lib_app/models/game/game.dart';

part 'wishlist_games_state.dart';

class WishlistGamesCubit extends Cubit<WishlistGamesState> {
  WishlistGamesCubit() : super(WishlistGamesState([]));
  void addGame(Game game) {
    state.list.add(game);
    List<Game> temp = state.list;
    emit(WishlistGamesState(temp));
  }

  void removeGame(int id) {
    for (Game favGame in state.list) {
      if (id == favGame.id) {
        state.list.remove(favGame);
        List<Game> temp = state.list;
        emit(WishlistGamesState(temp));
        break;
      }
    }
  }
}
