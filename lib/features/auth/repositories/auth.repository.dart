import 'dart:convert';
import 'dart:developer';

import 'package:big_wallet/core/repositories/base.repository.dart';
import 'package:big_wallet/core/responses/collection.response.dart';
import 'package:big_wallet/core/responses/single.response.dart';
import 'package:big_wallet/enums/context.enum.dart';
import 'package:big_wallet/features/auth/model/exchangeRates.model.dart';
import 'package:big_wallet/features/auth/model/primary.model.dart';
import 'package:big_wallet/features/auth/model/signin.model.dart';
import 'package:big_wallet/features/auth/model/signup.model.dart';
import 'package:big_wallet/features/auth/repositories/requests/revokeToken.request.dart';
import 'package:big_wallet/features/auth/repositories/requests/signin.request.dart';
import 'package:big_wallet/features/auth/repositories/requests/signup.request.dart';
import 'package:big_wallet/utilities/api.dart';
import 'package:big_wallet/utilities/common.dart';
import 'package:big_wallet/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AuthRepository extends Repository {
  Future<bool> signupAsync(BuildContext context, SignUpRequest data) async {
    const url = Api.postSignUp;
    final apiResponse = await requestAsync<SingleResponse>(
        Context.signup, context, url, RequestType.post,
        data: data);
    if (apiResponse.isSuccess) {
      var signup = SignUp.fromJson(apiResponse.payload);
    }
    return apiResponse.isSuccess;
  }

  Future<bool> signInAsync(BuildContext context, SignInRequest data) async {
    const url = Api.postSignIn;

    final apiResponse = await requestAsync<SingleResponse>(
        Context.signin, context, url, RequestType.post,
        data: data);
    if (apiResponse.isSuccess) {
      String signIn = json.encode(apiResponse.payload);
      Common().setStringSharedPreference(Constants.BIG_WALLET, signIn);
    }
    return apiResponse.isSuccess;
  }

  Future<bool> revokeTokenAsync(
      BuildContext context, RevokeTokenRequest data) async {
    const url = Api.postRevokeToken;

    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, context, url, RequestType.post,
        data: data, useToken: true);
    return apiResponse.isSuccess;
  }

  Future<bool> refreshTokenAsync(
      BuildContext context, RefreshTokenRequest data) async {
    const url = Api.postRevokeToken;

    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, context, url, RequestType.post,
        data: data);
    if (apiResponse.isSuccess) {
      var refreshToken = SignUp.fromJson(apiResponse.payload);
    }
    return apiResponse.isSuccess;
  }

  Future<PrimaryModel> getPrimaryAsync(BuildContext context) async {
    const url = Api.getPrimary;
    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, context, url, RequestType.get,
        useToken: true);
    return PrimaryModel.fromJson(apiResponse.payload);
  }

  Future<ExchangeRates> getExchangeRatesAsync(BuildContext context) async {
    const url = Api.getExchangeRates;
    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, context, url, RequestType.get,
        useToken: true);
    Logger().d('apiResponse:$apiResponse');
    final result = ExchangeRates.fromJson(apiResponse.payload);
    return result;
  }
}
