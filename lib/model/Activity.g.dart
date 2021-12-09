// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return Activity(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
    json['repeatable'] as bool,
    DateTime.parse(json['creationDate'] as String),
    json['endDate'] == null ? null : DateTime.parse(json['endDate'] as String),
  );
}

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'repeatable': instance.repeatable,
      'creationDate': instance.creationDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };
