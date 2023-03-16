import 'package:big_wallet/core/repositories/base.repository.dart';
import 'package:big_wallet/core/responses/single.response.dart';
import 'package:big_wallet/enums/context.enum.dart';
import 'package:big_wallet/features/auth/model/primary.model.dart';
import 'package:big_wallet/features/settings/repositories/requests/create_profile.request.dart';
import 'package:big_wallet/utilities/api.dart';
import 'package:flutter/widgets.dart';

class ProfileRepository extends Repository {
  Future<PrimaryModel> detailProfileAsync(
      BuildContext context, String id) async {
    var url = Api.getByIdProfile.replaceAll("%id%", id);
    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, context, url, RequestType.get,
        useToken: true);
    final result = PrimaryModel.fromJson(apiResponse.payload);
    return result;
  }

  Future<List<PrimaryModel>> listProfileAsync(BuildContext context) async {
    var url = Api.getProfiles;
    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, context, url, RequestType.get,
        useToken: true);
    final result = <PrimaryModel>[];
    apiResponse.payload?.forEach((element) {
      result.add(PrimaryModel.fromJson(element));
    });
    return result;
  }

  Future<bool> createProfileAsync(
      BuildContext context, CreateProfilesRequest data) async {
    var url = Api.getProfiles;
    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, context, url, RequestType.post,
        data: data, useToken: true);
    return apiResponse.isSuccess;
  }

  Future<bool> editProfileAsync(BuildContext context, String data) async {
    var url = Api.getProfiles;
    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, context, url, RequestType.put,
        data: data, useToken: true);
    return apiResponse.isSuccess;
  }
}
