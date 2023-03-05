import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Common {
  setStringSharedPreference(key, value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
