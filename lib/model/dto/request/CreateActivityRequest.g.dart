// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CreateActivityRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateActivityRequest _$CreateActivityRequestFromJson(
    Map<String, dynamic> json) {
  return CreateActivityRequest(
    name: json['name'] as String,
    description: json['description'] as String,
    repeatable: json['repeatable'] as bool,
  );
}

Map<String, dynamic> _$CreateActivityRequestToJson(
        CreateActivityRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'repeatable': instance.repeatable,
    };
