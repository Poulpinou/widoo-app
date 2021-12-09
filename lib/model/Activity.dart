import 'package:json_annotation/json_annotation.dart';

part 'Activity.g.dart';

@JsonSerializable()
class Activity {
  final int id;
  final String name;
  final String description;
  final bool repeatable;
  final DateTime creationDate;
  final DateTime? endDate;

  const Activity(
    this.id,
    this.name,
    this.description,
    this.repeatable,
    this.creationDate,
    this.endDate,
  );

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}
