// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'involved_company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvolvedCompany _$InvolvedCompanyFromJson(Map json) => InvolvedCompany(
      company: json['company'] == null
          ? null
          : FieldWithName.fromJson(
              Map<String, dynamic>.from(json['company'] as Map)),
    );

Map<String, dynamic> _$InvolvedCompanyToJson(InvolvedCompany instance) =>
    <String, dynamic>{
      'company': instance.company?.toJson(),
    };
