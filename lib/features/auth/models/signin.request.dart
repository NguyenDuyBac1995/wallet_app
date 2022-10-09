import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SignInRequest {
  final String user;
  final String password;
  SignInRequest(this.user, this.password);
}
