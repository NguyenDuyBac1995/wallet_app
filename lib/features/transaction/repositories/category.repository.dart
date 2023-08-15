import 'package:big_wallet/core/repositories/base.repository.dart';
import 'package:big_wallet/core/responses/single.response.dart';
import 'package:big_wallet/enums/context.enum.dart';
import 'package:big_wallet/features/transaction/model/categorys_model.dart';
import 'package:big_wallet/utilities/api.dart';
import 'package:flutter/material.dart';

class CategoryRepository extends Repository {
  Future<List<ResponseCategoriesIcon>> getListCategoryIcon(
      BuildContext content, data) async {
    var url = Api.getCategoriesIcon.replaceAll("%id%", data);
    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, content, url, RequestType.get,
        useToken: true);
    final result = <ResponseCategoriesIcon>[];
    apiResponse.payload?.forEach((element) {
      result.add(ResponseCategoriesIcon.fromJson(element));
    });
    return result;
  }

  Future<List<ResponseCategories>> getListCategory(
      BuildContext content, data) async {
    var url = Api.getCategories;
    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, content, url, RequestType.get,
        useToken: true);
    final result = <ResponseCategories>[];
    apiResponse.payload?.forEach((element) {
      result.add(ResponseCategories.fromJson(element));
    });
    return result;
  }

  Future<ResponseCategories> getCategoryDetail(
      BuildContext content, data) async {
    var url = Api.getCategoriesId.replaceAll("%id%", data);
    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, content, url, RequestType.get,
        useToken: true);
    final result = ResponseCategories.fromJson(apiResponse.payload);
    return result;
  }

  Future<bool> postListCategory(
      BuildContext context, RequestCategories data) async {
    var url = Api.postCategories;
    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, context, url, RequestType.post,
        data: data, useToken: true);
    return apiResponse.isSuccess;
  }

  Future<bool> putListCategory(
      BuildContext content, RequestPutCategories data) async {
    var url = Api.putCategories.replaceAll("%id%", data.id!);

    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, content, url, RequestType.put,
        data: data.requestCategories, useToken: true);

    return apiResponse.isSuccess;
  }

  Future<bool> deleteListCategory(BuildContext content, String data) async {
    var url = Api.deleteCategories.replaceAll("%id%", data);

    final apiResponse = await requestAsync<SingleResponse>(
        Context.general, content, url, RequestType.delete,
        data: data, useToken: true);

    return apiResponse.isSuccess;
  }
}
