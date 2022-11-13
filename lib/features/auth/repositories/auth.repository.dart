import 'package:big_wallet/core/repositories/base.repository.dart';
import 'package:big_wallet/core/responses/single.response.dart';
import 'package:big_wallet/features/auth/model/signup.model.dart';
import 'package:big_wallet/utilities/api.dart';
import 'package:flutter/material.dart';

class AuthRepository extends Repository {
  Future<SignUp> signupAsync(BuildContext context, dynamic data) async {
    const url = Api.signup;
    final apiResponse = await requestAsync<SingleResponse>(
        context, url, RequestType.post,
        data: data);
    final result = SignUp.fromJson(apiResponse?.payload);
    return result;
  }
}
