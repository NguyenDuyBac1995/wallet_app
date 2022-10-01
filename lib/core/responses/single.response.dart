import 'package:big_wallet/core/responses/base.response.dart';

class SingleResponse extends ApiResponse {
  dynamic payload;

  SingleResponse({statusCode, message, type, this.payload})
      : super(message: message, statusCode: statusCode, type: type);

  SingleResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    payload = json['Payload'];
    message = json['Message'];
    type = json['Type'];
  }
}
