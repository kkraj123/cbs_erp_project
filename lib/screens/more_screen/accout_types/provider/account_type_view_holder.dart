import 'package:cbs_erp_project/network/core/errors/app_exception.dart';
import 'package:cbs_erp_project/network/core/network/api_state.dart';
import 'package:cbs_erp_project/screens/more_screen/accout_types/model/FinTypeListItems.dart';
import 'package:cbs_erp_project/screens/more_screen/accout_types/model/account_type_list_response.dart';
import 'package:cbs_erp_project/screens/more_screen/accout_types/provider/account_type_repo.dart';
import 'package:cbs_erp_project/screens/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountTypeViewHolder
    extends StateNotifier<ApiState<AccountTypeListResponse>> {
  final AccountTypeRepo accountTypeRepo;

  AccountTypeViewHolder({required this.accountTypeRepo})
    : super(ApiState.initial());

  getAccountType() async {
    state = ApiState.loading();
    try {
      final accountTypeResponse = await accountTypeRepo.getAccountTypeList();
      state = ApiState.success(accountTypeResponse);
    } on AppException catch (e) {
      state = ApiState.error(e.message);
    } catch (e) {
      state = ApiState.error(e.toString());
    }
  }
}

final accountItems = Provider<AccountTypeRepo>((ref) {
  return AccountTypeRepo(networkService: ref.watch(networkServiceProvider));
});
final accountTypeProvider =
    StateNotifierProvider<
      AccountTypeViewHolder,
      ApiState<AccountTypeListResponse>
    >((ref) {
      return AccountTypeViewHolder(accountTypeRepo: ref.watch(accountItems));
    });

class FinTypeViewHolder extends StateNotifier<ApiState<FinTypeListResponse>> {
  final AccountTypeRepo accountTypeRepo;

  FinTypeViewHolder({required this.accountTypeRepo})
    : super(ApiState.initial());

  getFinTypeList() async {
    state = ApiState.loading();
    try {
      final finTypeListResponse = await accountTypeRepo.getFinTypeList();
      state = ApiState.success(finTypeListResponse);
    } on AppException catch (e) {
      state = ApiState.error(e.message);
    } catch (e) {
      state = ApiState.error(e.toString());
    }
  }
}

final finTypeList = Provider<AccountTypeRepo>((ref) {
  return AccountTypeRepo(networkService: ref.watch(networkServiceProvider));
});

final finTypeListProvider =
    StateNotifierProvider<FinTypeViewHolder, ApiState<FinTypeListResponse>>((ref) {
      return FinTypeViewHolder(accountTypeRepo: ref.watch(finTypeList));
    });
