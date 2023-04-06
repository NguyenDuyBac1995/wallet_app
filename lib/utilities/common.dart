import 'dart:async';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Common {
  setStringSharedPreference(key, value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  String formatData(String strDate) {
    return DateFormat('dd-MM-yyyy').format(DateTime.parse(strDate));
  }

  String getValueByKey(List<dynamic> list, String key) {
    for (var item in list) {
      if (item["Key"] == key) {
        return item["Value"];
      }
    }
    return '';
  }
}
