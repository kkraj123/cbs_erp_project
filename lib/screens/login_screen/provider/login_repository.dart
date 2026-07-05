import 'package:cbs_erp_project/network/core/network/api_constants.dart';
import 'package:cbs_erp_project/network/core/network/network_service.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';

class LoginRepository {
  final NetworkService networkService;

  LoginRepository({required this.networkService});

  Future<AuthModel> userLogin({
    required String branchCode,
    required String userName,
    required String password,
    required String deviceToken,
  }) async {
    final bodyParams = {
      "brcode": branchCode,
      "username": userName,
      "password": password,
      "browser": 'cbsmobile',
      "deviceToken": deviceToken,
    };
    final response = await networkService.post(
      ApiConstants.loginEndPoint,
      bodyParams,
      null,
      null,
    );
    return AuthModel.fromJson(response);
  }

  Future<AuthModel> otpVerification({
    required String branchCode,
    required String userName,
    required String password,
    required String deviceToken,
    required String otpToken
  }) async {
    final bodyParam = {
      "brcode": branchCode,
      "username": userName,
      "otp_token": otpToken,
      "browser": 'cbsmobile',
      "ipaddress": "",
      "deviceToken" : deviceToken
    };
    final response = await networkService.post(
      ApiConstants.optVerifyingEndPoint,
      bodyParam,
      null,
      null,
    );
    return AuthModel.fromJson(response);
  }
}
