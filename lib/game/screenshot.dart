import 'package:json_annotation/json_annotation.dart';

part 'screenshot.g.dart';

@JsonSerializable()
class Screenshot {
  final String? url;

  Screenshot({this.url});
  factory Screenshot.fromJson(Map<String, dynamic> json) =>
      _$ScreenshotFromJson(json);
  Map<String, dynamic> toJson() => _$ScreenshotToJson(this);
}
