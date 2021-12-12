import 'package:json_annotation/json_annotation.dart';

part 'entities.g.dart';

@JsonSerializable()
class Message {
  String author;
  String message;

  Message(
    this.author,
    this.message,
  );

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
