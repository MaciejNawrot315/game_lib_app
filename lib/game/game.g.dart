// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      name: json['name'] as String,
      summary: json['summary'] as String?,
      cover: Cover.fromJson(json['cover'] as Map<String, dynamic>),
      rating: (json['rating'] as num).toDouble(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'name': instance.name,
      'summary': instance.summary,
      'cover': instance.cover,
      'rating': instance.rating,
      'genres': instance.genres,
    };
