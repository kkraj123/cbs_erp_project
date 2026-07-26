import 'package:cbs_erp_project/network/core/errors/app_exception.dart';
import 'package:cbs_erp_project/network/core/network/api_state.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:cbs_erp_project/screens/provider.dart';
import 'package:cbs_erp_project/screens/login_screen/provider/login_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel extends StateNotifier<ApiState<AuthModel>> {
  final LoginRepository loginRepository;

  LoginViewModel({required this.loginRepository}) : super(ApiState.initial());

  Future<void> loginApi({
    required String branchCode,
    required String userName,
    required String password,
    required String deviceToken,
  }) async {
    state = ApiState.loading();
    try {
      final loginResponse = await loginRepository.userLogin(
        branchCode: branchCode,
        userName: userName,
        password: password,
        deviceToken: deviceToken,
      );
      state = ApiState.success(loginResponse);
    } on AppException catch (e) {
      state = ApiState.error(e.message);
    } catch (e) {
      state = ApiState.error(e.toString());
    }
  }

  Future<void> otpVerification({
    required String branchCode,
    required String userName,
    required String password,
    required String deviceToken,
    required String otp,
  }) async {
    state = ApiState.loading();
    try {
      final loginResponse = await loginRepository.otpVerification(
        branchCode: branchCode,
        userName: userName,
        password: password,
        deviceToken: deviceToken,
        otpToken: otp,
      );
      state = ApiState.success(loginResponse);
    } on AppException catch (e) {
      state = ApiState.error(e.message);
    } catch (e) {
      state = ApiState.error(e.toString());
    }
  }
}

final authRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepository(networkService: ref.watch(networkServiceProvider));
});

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, ApiState<AuthModel>>((ref) {
      return LoginViewModel(loginRepository: ref.watch(authRepositoryProvider));
    });
