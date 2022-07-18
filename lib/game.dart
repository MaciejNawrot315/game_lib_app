import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  final String? name, summary;
  String? coverUrl;
  final int? cover;
  final double? rating;
  Game({this.name, this.summary, this.cover, this.coverUrl, this.rating});
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}
