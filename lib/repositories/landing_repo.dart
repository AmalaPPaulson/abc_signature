import 'dart:developer';

import 'package:dio/dio.dart';

import '../utils/api_query.dart';
import '../utils/constants/api_constants.dart';

class LandingRepository {
  ApiQuery apiQuery = ApiQuery();


//District name getting query
  Future<Response?> distName() async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> query = {
      };
      log('distName');

      log('Query printing ::: ${query.toString()}');

      Response? response = await apiQuery.getQuery(
          APIConstants.distName,
          headers,
          query,
          'DistrictName',
          false,
          true,
          false);
      return response;
    } catch (exception) {
      return null;
    }
  }

//District name getting query
  Future<Response?> getDealersList(String distName) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> query = {
      };

      String apiUrl = '${APIConstants.dealersList}?place=$distName';
      log('url is $apiUrl');
      log('Query printing ::: ${query.toString()}');

      Response? response = await apiQuery.getQuery(
          apiUrl,
          headers,
          query,
          'Dealers list',
          false,
          true,
          false);
      return response;
    } catch (exception) {
      return null;
    }
  }

  Future<Response?> getLeadsList(String distName) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> query = {
      };

      String apiUrl = '${APIConstants.leadsList}?place=$distName';
      log('url is $apiUrl');
      log('Query printing ::: ${query.toString()}');

      Response? response = await apiQuery.getQuery(
          apiUrl,
          headers,
          query,
          'Dealers list',
          false,
          true,
          false);
      return response;
    } catch (exception) {
      return null;
    }
  }
}