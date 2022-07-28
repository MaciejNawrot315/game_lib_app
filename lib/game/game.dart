import 'package:game_lib_app/game/cover.dart';
import 'package:game_lib_app/game/involved_company.dart';
import 'package:game_lib_app/game/screenshot.dart';
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
  final int? first_release_date;
  final Collection? collection;
  final List<FieldWithName>? dlcs;
  final List<FieldWithName>? expansions;
  final List<FieldWithName>? franchises;
  final List<InvolvedCompany>? involved_companies;
  final FieldWithName? parent_game;
  final List<FieldWithName>? platforms;
  final int? rating_count;
  final List<FieldWithName>? game_modes;
  final List<Screenshot>? screenshots;
  Game(
      {required this.id,
      this.name,
      this.summary,
      this.cover,
      this.rating,
      this.genres,
      this.first_release_date,
      this.dlcs,
      this.collection,
      this.expansions,
      this.franchises,
      this.involved_companies,
      this.parent_game,
      this.platforms,
      this.rating_count,
      this.game_modes,
      this.screenshots});
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}
