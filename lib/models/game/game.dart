import 'package:game_lib_app/models/game/cover.dart';
import 'package:game_lib_app/models/game/involved_company.dart';
import 'package:game_lib_app/models/game/screenshot.dart';
import 'package:json_annotation/json_annotation.dart';

import 'collection.dart';

import 'field_with_name.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  final int id;
  final String? name;
  final String? summary;
  final Cover? cover;
  final double? rating;
  final List<FieldWithName>? genres;
  @JsonKey(name: 'first_release_date')
  final int? firstReleaseDate;
  final Collection? collection;
  final List<FieldWithName>? dlcs;
  final List<FieldWithName>? expansions;
  final List<FieldWithName>? franchises;
  @JsonKey(name: 'involved_companies')
  final List<InvolvedCompany>? involvedCompanies;
  @JsonKey(name: 'parent_game')
  final FieldWithName? parentGame;
  final List<FieldWithName>? platforms;
  @JsonKey(name: 'rating_count')
  final int? ratingCount;
  @JsonKey(name: 'game_modes')
  final List<FieldWithName>? gameModes;
  final List<Screenshot>? screenshots;
  Game({
    required this.id,
    this.name,
    this.summary,
    this.cover,
    this.rating,
    this.genres,
    this.firstReleaseDate,
    this.dlcs,
    this.collection,
    this.expansions,
    this.franchises,
    this.involvedCompanies,
    this.parentGame,
    this.platforms,
    this.ratingCount,
    this.gameModes,
    this.screenshots,
  });
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}
