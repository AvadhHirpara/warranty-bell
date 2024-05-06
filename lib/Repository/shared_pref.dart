import 'dart:convert';
import 'package:WarrantyBell/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await json.decode(prefs.getString(key).toString());
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  removeAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

}