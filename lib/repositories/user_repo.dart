import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_model.dart';
import '../utils/api_query.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/string_constants.dart';

class UserRepository {
  ApiQuery apiQuery = ApiQuery();

//Login
  Future<Response?> login(String password,String userId) async {
    try {

      Map<String, dynamic> body = {
        "username": userId,
        "password": password,
        // "fcm_token": fcmToken
      };

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Response? response =
      await apiQuery.postQuery(APIConstants.login, headers, body, 'Login');
      return response;
    } catch (exception) {
      return null;
    }
  }

  // posting device and location details
  Future<Response?> checkInTodayDetails(String checkInDate,String loc,String deviceId,String deviceName) async {
    try {

      Map<String, dynamic> body = {
        "check_in_at": checkInDate,
        "location": loc,
        "device_name": deviceName,
        "device_id": deviceId,
        // "fcm_token": fcmToken
      };

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Response? response =
      await apiQuery.postQuery(APIConstants.checkInToday, headers, body, 'checkInTodayDetails');
      return response;
    } catch (exception) {
      return null;
    }
  }

  //Set is Logged
  setIsLogged(bool isLogged) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(StringConstants.IS_LOGGED_IN, isLogged);
  }

  //Get Is Logged
  Future<bool?> getIsLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(StringConstants.IS_LOGGED_IN) ?? false;
  }


  //store shop profile model
  storeUserDetails(LoginModel? loginModel) async {
    if (loginModel != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userDetailsJson = json.encode(loginModel);
      prefs.setString(StringConstants.USER_DETAILS, userDetailsJson);
    }
  }

  //Get User Details
  Future<LoginModel?> getUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(StringConstants.USER_DETAILS) == null) {
      return null;
    } else {
      String? userResponse =
      prefs.getString(StringConstants.USER_DETAILS);
      return LoginModel.fromJson(jsonDecode(userResponse!));
    }
  }

  //Store Email Id
  storeCheckInDate(String storeCheckInDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(StringConstants.CHECK_IN_DATE, storeCheckInDate);
  }

  //Get Email Id
  Future<String?> getCheckInDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(StringConstants.CHECK_IN_DATE) != null) {
      return prefs.getString(StringConstants.CHECK_IN_DATE);
    } else {
      return null;
    }
  }

}