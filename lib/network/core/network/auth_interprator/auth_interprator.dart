import 'dart:io';

import 'package:cbs_erp_project/network/core/network/api_constants.dart';
import 'package:dio/dio.dart';


class AuthorizationInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path != ApiConstants.baseUrl) {
      String auth = '';
      // OAuth? oAuth = await SharedPreferenceManager.getOAuth();
      if (auth != null) {
        /*  options.headers = {
          HttpHeaders.authorizationHeader: 'bearer ${oAuth.accessToken}',
        };*/
        Map<String, String> authHeader = {
          // HttpHeaders.authorizationHeader: 'bearer ${oAuth.accessToken}'
          HttpHeaders.authorizationHeader: 'bearer ${auth}'
        };
        options.headers.addAll(authHeader);
      }
    }
    // AppLog.i("AuthorizationInterceptor", "${options.headers}");

    super.onRequest(options, handler);
  }
}