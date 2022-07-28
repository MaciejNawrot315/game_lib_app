import 'package:json_annotation/json_annotation.dart';

part 'field_with_name.g.dart';

@JsonSerializable()
class FieldWithName {
  final String? name;

  FieldWithName({this.name});
  factory FieldWithName.fromJson(Map<String, dynamic> json) =>
      _$FieldWithNameFromJson(json);
  Map<String, dynamic> toJson() => _$FieldWithNameToJson(this);
}
