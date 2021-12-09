import 'package:json_annotation/json_annotation.dart';

part 'CreateActivityRequest.g.dart';

@JsonSerializable()
class CreateActivityRequest {
  final String name;
  final String description;
  final bool repeatable;

  const CreateActivityRequest(
      {required this.name, required this.description, this.repeatable = false});

  Map<String, dynamic> toJson() => _$CreateActivityRequestToJson(this);
}
