import 'package:game_lib_app/game/cover.dart';
import 'package:json_annotation/json_annotation.dart';

import 'genre.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  final String name, summary;
  final Cover cover;
  final double rating;
  final List<Genre> genres;
  Game(
      {required this.name,
      required this.summary,
      required this.cover,
      required this.rating,
      required this.genres});
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}
