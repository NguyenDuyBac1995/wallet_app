import 'package:big_wallet/core/repositories/base.repository.dart';
import 'package:big_wallet/core/responses/single.response.dart';
import 'package:big_wallet/enums/context.enum.dart';
import 'package:big_wallet/features/wallet/model/wallets_model.dart';
import 'package:big_wallet/features/wallet/repositories/requests/wallets_requests.dart';
import 'package:big_wallet/utilities/api.dart';
import 'package:flutter/material.dart';

class WalletRepository extends Repository {
  Future<bool> createWalletAsync(
      BuildContext content, RequestCreateWallet data) async {
    var url = Api.createWallets;
    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, content, url, RequestType.post,
        data: data, useToken: true);

    return apiResponse.isSuccess;
  }

  Future<ResponseWallet> getListWalletsAsync(
      BuildContext content, String data) async {
    var url = Api.getWallets;
    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, content, url, RequestType.get,
        useToken: true);
    final result = ResponseWallet.fromJson(apiResponse.payload);

    return result;
  }

  Future<bool> updateWalletAsync(
      BuildContext content, RequestUpdateWallet data) async {
    var url = Api.updateWallets.replaceAll("%id%", data.id!);
    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, content, url, RequestType.put,
        data: data.requestUpdateWallet, useToken: true);

    return apiResponse.isSuccess;
  }

  Future<ResponseWalletById> getWalletByIdAsync(
      BuildContext content, String data) async {
    var url = Api.getWalletsById.replaceAll("%id%", data);
    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, content, url, RequestType.get,
        useToken: true);
    final result = ResponseWalletById.fromJson(apiResponse.payload);

    return result;
  }
}
