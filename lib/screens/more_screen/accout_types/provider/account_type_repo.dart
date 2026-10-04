import 'package:cbs_erp_project/network/core/network/api_constants.dart';
import 'package:cbs_erp_project/network/core/network/network_service.dart';
import 'package:cbs_erp_project/screens/more_screen/accout_types/model/FinTypeListItems.dart';
import 'package:cbs_erp_project/screens/more_screen/accout_types/model/account_type_list_response.dart';

class AccountTypeRepo {
  final NetworkService networkService;

  AccountTypeRepo({required this.networkService});

  Future<AccountTypeListResponse> getAccountTypeList() async {
    final accountTypeResponse = await networkService.get(
      ApiConstants.accountTypeEndPoint,
      null,
      null,
    );
    return AccountTypeListResponse.fromJson(accountTypeResponse);
  }
  Future<FinTypeListResponse> getFinTypeList() async{
    final finTypeResponse = await networkService.get(ApiConstants.finTypeListEndPoint, null, null);
    return FinTypeListResponse.fromJson(finTypeResponse);
  }
}
