// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:game_lib_app/models/game/game.dart';

class User {
  final String id;
  final String name;
  final String email;
  List<Game> favGames;
  List<Game> playedGames;
  List<Game> wishlistGames;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.favGames,
    required this.playedGames,
    required this.wishlistGames,
  });

  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>?;

    return User(
      id: userDoc.id,
      name: userData!['name'],
      email: userData['email'],
      favGames: List<Game>.from(
          userData['favGames'].map((game) => Game.fromJson(game))),
      playedGames: List<Game>.from(
          userData['playedGames'].map((game) => Game.fromJson(game))),
      wishlistGames: List<Game>.from(
          userData['wishlistGames'].map((game) => Game.fromJson(game))),
    );
  }

  factory User.initial() {
    return User(
      id: '',
      name: '',
      email: '',
      favGames: [],
      playedGames: [],
      wishlistGames: [],
    );
  }
}
