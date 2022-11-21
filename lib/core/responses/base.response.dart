class ApiResponse {
  int? statusCode;
  String? message;
  String? type;
  late bool isSuccess;

  ApiResponse({this.statusCode, this.message, this.type});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    type = json['Type'];
    isSuccess = statusCode == 201 || statusCode == 200 ? true : false;
  }
}
