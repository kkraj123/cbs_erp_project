import 'package:cbs_erp_project/network/core/network/api_constants.dart';
import 'package:cbs_erp_project/network/core/network/network_service.dart';
import 'package:cbs_erp_project/screens/home_screen/model/category_item_by_logic.dart';
import 'package:cbs_erp_project/screens/more_screen/category_items/model/CategorySaveItemResponse.dart';
import 'package:cbs_erp_project/screens/more_screen/category_items/model/CategryItems.dart';

class CategoryRepo {
  final NetworkService networkService;

  CategoryRepo({required this.networkService});

  Future<CategoryItemsResponse> getCategoryItems() async {
    final response = await networkService.get(
      ApiConstants.categoryItemsTypeEndPoint,
      null,
      null,
    );
    return CategoryItemsResponse.fromJson(response);
  }

  Future<CategorySaveItemResponse> saveCategoryItems(
    Map<String, dynamic> bodyParams,
  ) async {
    final saveCategoryItemResponse = await networkService.post(
      ApiConstants.categorySaveItemEndPoint,
      null,
      null,
      bodyParams,
    );
    return CategorySaveItemResponse.fromJson(saveCategoryItemResponse);
  }

  Future<CategoryItemsByLogic> getCategoryByLogic() async {
    final categoryByLogicResponse = await networkService.get(
      ApiConstants.categoryByIsLogicEndPoint,
      null,
      null,
    );
    return CategoryItemsByLogic.fromJson(categoryByLogicResponse);
  }
}
