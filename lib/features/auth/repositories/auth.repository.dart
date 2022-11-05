import 'package:big_wallet/core/repositories/base.repository.dart';
import 'package:big_wallet/core/responses/single.response.dart';
import 'package:big_wallet/models/auth/auth.model.dart';
import 'package:big_wallet/utilities/api.dart';

class AuthRepository extends Repository {
  Future<SignUp> signupAsync() async {
    const url = Api.signup;
    final apiResponse =
        await requestAsync<SingleResponse>(url, RequestType.post);
    final result = SignUp.fromJson(apiResponse.payload);
    return result;
  }
}
