import 'package:json_annotation/json_annotation.dart';

part 'ActivityCountResponse.g.dart';

@JsonSerializable()
class ActivityCountResponse {
  final int total;
  final int active;
  final int done;

  const ActivityCountResponse(this.total, this.active, this.done);

  factory ActivityCountResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivityCountResponseFromJson(json.map((key, value) => MapEntry(key, value ?? 0)));
}
