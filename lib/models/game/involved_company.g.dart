// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'involved_company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvolvedCompany _$InvolvedCompanyFromJson(Map<String, dynamic> json) =>
    InvolvedCompany(
      company: json['company'] == null
          ? null
          : FieldWithName.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvolvedCompanyToJson(InvolvedCompany instance) =>
    <String, dynamic>{
      'company': instance.company,
    };
