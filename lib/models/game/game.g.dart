// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map json) => Game(
      id: json['id'] as int,
      name: json['name'] as String?,
      summary: json['summary'] as String?,
      cover: json['cover'] == null
          ? null
          : Cover.fromJson(Map<String, dynamic>.from(json['cover'] as Map)),
      rating: (json['rating'] as num?)?.toDouble(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) =>
              FieldWithName.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      first_release_date: json['first_release_date'] as int?,
      dlcs: (json['dlcs'] as List<dynamic>?)
          ?.map((e) =>
              FieldWithName.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      collection: json['collection'] == null
          ? null
          : Collection.fromJson(
              Map<String, dynamic>.from(json['collection'] as Map)),
      expansions: (json['expansions'] as List<dynamic>?)
          ?.map((e) =>
              FieldWithName.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      franchises: (json['franchises'] as List<dynamic>?)
          ?.map((e) =>
              FieldWithName.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      involved_companies: (json['involved_companies'] as List<dynamic>?)
          ?.map((e) =>
              InvolvedCompany.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      parent_game: json['parent_game'] == null
          ? null
          : FieldWithName.fromJson(
              Map<String, dynamic>.from(json['parent_game'] as Map)),
      platforms: (json['platforms'] as List<dynamic>?)
          ?.map((e) =>
              FieldWithName.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      rating_count: json['rating_count'] as int?,
      game_modes: (json['game_modes'] as List<dynamic>?)
          ?.map((e) =>
              FieldWithName.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      screenshots: (json['screenshots'] as List<dynamic>?)
          ?.map((e) => Screenshot.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'summary': instance.summary,
      'cover': instance.cover?.toJson(),
      'rating': instance.rating,
      'genres': instance.genres?.map((e) => e.toJson()).toList(),
      'first_release_date': instance.first_release_date,
      'collection': instance.collection?.toJson(),
      'dlcs': instance.dlcs?.map((e) => e.toJson()).toList(),
      'expansions': instance.expansions?.map((e) => e.toJson()).toList(),
      'franchises': instance.franchises?.map((e) => e.toJson()).toList(),
      'involved_companies':
          instance.involved_companies?.map((e) => e.toJson()).toList(),
      'parent_game': instance.parent_game?.toJson(),
      'platforms': instance.platforms?.map((e) => e.toJson()).toList(),
      'rating_count': instance.rating_count,
      'game_modes': instance.game_modes?.map((e) => e.toJson()).toList(),
      'screenshots': instance.screenshots?.map((e) => e.toJson()).toList(),
    };
