import 'dart:convert';
import 'package:big_wallet/features/auth/model/signin.model.dart';
import 'package:big_wallet/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static AuthUtils instance = AuthUtils();

  static String? _token = "";

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String? _tokenId;

  Future getToken() async {
    if (_token != null && _token!.isNotEmpty) {
      return _token;
    } else {
      final SharedPreferences prefs = await _prefs;
      String jsonString = prefs.getString(Constants.BIG_WALLET) ?? '';
      SignInModel dataUser = SignInModel.fromJson(json.decode(jsonString));
      _tokenId = dataUser.accessToken;
      if (_tokenId != null && _tokenId!.isNotEmpty) {
        _token = _tokenId;
      }
    }
    return _token;
  }

  void setToken(String token) {
    _token = token;
  }
}
