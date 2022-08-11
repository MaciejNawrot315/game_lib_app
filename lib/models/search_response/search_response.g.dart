// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map json) => SearchResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      game: json['game'] == null
          ? null
          : Game.fromJson(Map<String, dynamic>.from(json['game'] as Map)),
    );

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'game': instance.game?.toJson(),
    };
