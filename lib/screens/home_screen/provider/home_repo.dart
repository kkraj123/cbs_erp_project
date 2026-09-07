import 'package:cbs_erp_project/network/core/network/api_constants.dart';
import 'package:cbs_erp_project/network/core/network/network_service.dart';
import 'package:cbs_erp_project/screens/home_screen/model/category_item_by_logic.dart';
import 'package:cbs_erp_project/screens/home_screen/model/item_save_model.dart';
import 'package:cbs_erp_project/screens/home_screen/model/unit_reponse.dart';

class HomeRepo {
  final NetworkService networkService;

  HomeRepo({required this.networkService});

  Future<CategoryItemsByLogic> getCategoryItemsForDropdown() async {
    final responseData = await networkService.get(
      ApiConstants.categoryDropdownItemEnd,
      null,
      null,
    );
    return CategoryItemsByLogic.fromJson(responseData);
  }

  Future<UnitResponse> getUnits() async {
    final unitResponse = await networkService.get(
      ApiConstants.unitEndPoint,
      null,
      null,
    );
    return UnitResponse.fromJson(unitResponse);
  }

  Future<ItemSaveResponse> saveItems(Map<String, dynamic> bodyParams) async {
    final saveItemResponse = await networkService.post(
      ApiConstants.saveItemEndPoint,
      null,
      null,
      bodyParams,
    );
    return ItemSaveResponse.fromJson(saveItemResponse);
  }
}
