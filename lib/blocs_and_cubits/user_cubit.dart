import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/models/game/game.dart';
import 'package:game_lib_app/models/user.dart';
import 'package:game_lib_app/repositories/firestore_repository.dart';

enum UserListNames {
  favGames,
  playedGames,
  wishlistGames,
}

class UserCubit extends Cubit<User> {
  final FirestoreRepository firestoreRepository;
  UserCubit({
    required this.firestoreRepository,
  }) : super(User.initial());

  Future<void> getUser(String? uid) async {
    if (uid != null) {
      emit(await firestoreRepository.getProfile(
          uid: uid)); //metoda niedodajaca do bazy
    }
  }

  void addGameToList(Game game, UserListNames listName) {
    List<Game> temp;
    Game shortGame = Game(
      id: game.id,
      cover: game.cover,
      genres: game.genres,
      name: game.name,
      rating: game.rating,
    );
    switch (listName) {
      case UserListNames.favGames:
        temp = state.favGames;
        break;
      case UserListNames.playedGames:
        temp = state.playedGames;
        break;
      case UserListNames.wishlistGames:
        temp = state.wishlistGames;
        break;
    }

    temp.firstWhere((elemGame) => elemGame.id == shortGame.id, orElse: () {
      temp.add(shortGame);
      switch (listName) {
        case UserListNames.favGames:
          emit(state.copyWith(favGames: temp));
          firestoreRepository.addGameToFs(shortGame, 'favGames');
          break;
        case UserListNames.playedGames:
          emit(state.copyWith(playedGames: temp));
          firestoreRepository.addGameToFs(shortGame, 'playedGames');
          break;
        case UserListNames.wishlistGames:
          emit(state.copyWith(wishlistGames: temp));
          firestoreRepository.addGameToFs(shortGame, 'wishlistGames');
          break;
      }

      return shortGame;
    });
  }

  void removeGameFromList(Game game, UserListNames listName) {
    List<Game> temp;
    Game shortGame = Game(
      id: game.id,
      cover: game.cover,
      genres: game.genres,
      name: game.name,
      rating: game.rating,
    );
    switch (listName) {
      case UserListNames.favGames:
        temp = state.favGames;
        break;
      case UserListNames.playedGames:
        temp = state.playedGames;
        break;
      case UserListNames.wishlistGames:
        temp = state.wishlistGames;
        break;
    }

    for (Game elemGame in temp) {
      if (shortGame.id == elemGame.id) {
        temp.remove(elemGame);
        switch (listName) {
          case UserListNames.favGames:
            emit(state.copyWith(favGames: temp));
            firestoreRepository.removeGameFromFs(shortGame, 'favGames');
            break;
          case UserListNames.playedGames:
            emit(state.copyWith(playedGames: temp));
            firestoreRepository.removeGameFromFs(shortGame, 'playedGames');
            break;
          case UserListNames.wishlistGames:
            emit(state.copyWith(wishlistGames: temp));
            firestoreRepository.removeGameFromFs(shortGame, 'wishlistGames');
            break;
        }
        break;
      }
    }
  }

  bool containsInList(Game game, UserListNames listName) {
    List<Game> temp;

    switch (listName) {
      case UserListNames.favGames:
        temp = state.favGames;
        break;
      case UserListNames.playedGames:
        temp = state.playedGames;
        break;
      case UserListNames.wishlistGames:
        temp = state.wishlistGames;
        break;
    }
    return temp.any((elemGame) => elemGame.id == game.id);
  }

  void setToInitial() {
    emit(User.initial());
  }
}
