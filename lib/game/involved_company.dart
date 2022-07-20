import 'package:game_lib_app/game/field_with_name.dart';
import 'package:json_annotation/json_annotation.dart';

part 'involved_company.g.dart';

@JsonSerializable()
class InvolvedCompany {
  final FieldWithName? company;

  InvolvedCompany({this.company});
  factory InvolvedCompany.fromJson(Map<String, dynamic> json) =>
      _$InvolvedCompanyFromJson(json);
  Map<String, dynamic> toJson() => _$InvolvedCompanyToJson(this);
}
