import 'package:big_wallet/core/repositories/base.repository.dart';
import 'package:big_wallet/core/responses/single.response.dart';
import 'package:big_wallet/enums/context.enum.dart';
import 'package:big_wallet/features/auth/model/signup.model.dart';
import 'package:big_wallet/features/auth/repositories/requests/signup.request.dart';
import 'package:big_wallet/utilities/api.dart';
import 'package:flutter/material.dart';

class AuthRepository extends Repository {
  Future<bool> signupAsync(BuildContext context, SignUpRequest data) async {
    const url = Api.signup;
    final apiResponse = await requestAsync<SingleResponse>(
        Context.signup, context, url, RequestType.post,
        data: data);
    if (apiResponse.isSuccess) {
      var signup = SignUp.fromJson(apiResponse.payload);
    }
    return apiResponse.isSuccess;
  }
}
