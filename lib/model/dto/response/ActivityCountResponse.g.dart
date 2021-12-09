// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ActivityCountResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityCountResponse _$ActivityCountResponseFromJson(
    Map<String, dynamic> json) {
  return ActivityCountResponse(
    json['total'] as int,
    json['active'] as int,
    json['done'] as int,
  );
}

Map<String, dynamic> _$ActivityCountResponseToJson(
        ActivityCountResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'active': instance.active,
      'done': instance.done,
    };
