// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      name: json['name'] as String?,
      summary: json['summary'] as String?,
      cover: json['cover'] as int?,
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'name': instance.name,
      'summary': instance.summary,
      'cover': instance.cover,
      'rating': instance.rating,
    };
