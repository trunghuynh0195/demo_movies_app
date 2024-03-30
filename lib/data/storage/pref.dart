import 'dart:convert';
import 'dart:developer';

import 'package:demo_movies_app/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage_key.dart';

class Storage {
  static late SharedPreferences _p;
  static SharedPreferences get p => _p;

  static Future<void> init() async {
    log(name: 'SharedPreferences', 'initiated');
    _p = await SharedPreferences.getInstance();
  }

  // ----
  static String? get userJson => p.getString(StorageKey.userInfo);
  static User? get user => (userJson ?? '').isEmpty ? null : User.fromJson(jsonDecode(userJson!));
  static set user(User? value) => value == null ? p.remove(StorageKey.userInfo) : p.setString(StorageKey.userInfo, jsonEncode(value));
}
