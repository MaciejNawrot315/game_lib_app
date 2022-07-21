// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      id: json['id'] as int?,
      name: json['name'] as String?,
      summary: json['summary'] as String?,
      cover: json['cover'] == null
          ? null
          : Cover.fromJson(json['cover'] as Map<String, dynamic>),
      rating: (json['rating'] as num?)?.toDouble(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => FieldWithName.fromJson(e as Map<String, dynamic>))
          .toList(),
      first_release_date: json['first_release_date'] as int?,
      dlcs: (json['dlcs'] as List<dynamic>?)
          ?.map((e) => FieldWithName.fromJson(e as Map<String, dynamic>))
          .toList(),
      collection: json['collection'] == null
          ? null
          : Collection.fromJson(json['collection'] as Map<String, dynamic>),
      expansions: (json['expansions'] as List<dynamic>?)
          ?.map((e) => FieldWithName.fromJson(e as Map<String, dynamic>))
          .toList(),
      franchises: (json['franchises'] as List<dynamic>?)
          ?.map((e) => FieldWithName.fromJson(e as Map<String, dynamic>))
          .toList(),
      involved_companies: (json['involved_companies'] as List<dynamic>?)
          ?.map((e) => InvolvedCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
      parent_game: json['parent_game'] == null
          ? null
          : FieldWithName.fromJson(json['parent_game'] as Map<String, dynamic>),
      platforms: (json['platforms'] as List<dynamic>?)
          ?.map((e) => FieldWithName.fromJson(e as Map<String, dynamic>))
          .toList(),
      rating_count: json['rating_count'] as int?,
      game_modes: (json['game_modes'] as List<dynamic>?)
          ?.map((e) => FieldWithName.fromJson(e as Map<String, dynamic>))
          .toList(),
      screenshots: (json['screenshots'] as List<dynamic>?)
          ?.map((e) => Screenshot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'summary': instance.summary,
      'cover': instance.cover,
      'rating': instance.rating,
      'genres': instance.genres,
      'first_release_date': instance.first_release_date,
      'collection': instance.collection,
      'dlcs': instance.dlcs,
      'expansions': instance.expansions,
      'franchises': instance.franchises,
      'involved_companies': instance.involved_companies,
      'parent_game': instance.parent_game,
      'platforms': instance.platforms,
      'rating_count': instance.rating_count,
      'game_modes': instance.game_modes,
      'screenshots': instance.screenshots,
    };
