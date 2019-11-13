import 'package:json_annotation/json_annotation.dart';

part 'Response.g.dart';

class Response<T> {
  T data;
  int errorCode;
  String errorMsg;
  Error error;

  Response(this.data, this.errorCode, this.errorMsg, this.error);
}

@JsonSerializable()
class Error {
  Error(this.code, this.message, this.data);
  int code;
  String message;
  String data;

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
