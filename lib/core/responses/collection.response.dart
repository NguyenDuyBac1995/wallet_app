import 'package:big_wallet/core/responses/base.response.dart';

class CollectionResponse extends ApiResponse {
  int? totalCount;
  List<dynamic>? payload;

  CollectionResponse({statusCode, message, type, this.payload, this.totalCount})
      : super(message: message, statusCode: statusCode, type: type);

  CollectionResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    totalCount = json['TotalCount'];
    if (json['Payload'] != null) {
      payload = <dynamic>[];
      json['Payload'].forEach((v) {
        payload?.add(v);
      });
    }
    message = json['Message'];
    type = json['Type'];
  }
}
