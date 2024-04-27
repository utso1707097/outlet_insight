import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlet_insight/models/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceController extends GetxController {
  UserModel? user;
  SharedPreferences? _sharedPreferences;
  bool? authState;

  Future<void> initializePreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void onInit() {
    super.onInit();
    checkAuthStatewithUserModel();
  }

  Future<void> saveUserInformation(UserModel userModel) async {
    if (_sharedPreferences == null) {
      await initializePreferences();
    }
    await _sharedPreferences?.setString('user', jsonEncode(userModel.toJson()));
    final currentUser = _sharedPreferences?.get('user') as String?;
    if (currentUser != null) {
      log(currentUser);
    }
    user = userModel;
    authState = true;
    update();
  }

  Future<void> initializeUserCache() async {
    if (_sharedPreferences == null) {
      await initializePreferences();
    }
    var data = _sharedPreferences?.getString('user');

    if (data != null) {
      log(data);
      user = UserModel.fromJson(
        jsonDecode(data),
      );
    }
  }

  Future<void> checkAuthStatewithUserModel() async {
    if (_sharedPreferences == null) {
      await initializePreferences();
    }
    log("Checking auth State....");
    await initializeUserCache();
    update();
    if (user != null) {
      authState = true;
    } else {
      authState = false;
    }
    log("Auth State = $authState");
    update();
  }

  Future<UserModel?> getCurrentUser() async {
    if (_sharedPreferences == null) {
      await initializePreferences();
    }
    log("Seinding data to dashboard....");
    await initializeUserCache();
    update();
    if (user != null) {
      return user;
    }
    return null;
  }

  Future<void> logout() async {
    if (_sharedPreferences == null) {
      await initializePreferences();
    }
    await _sharedPreferences?.clear();
    authState = false;
    user = null;
    update();
  }
}
