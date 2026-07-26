import 'package:cbs_erp_project/network/core/network/api_constants.dart';
import 'package:cbs_erp_project/network/core/network/network_service.dart';
import 'package:cbs_erp_project/screens/more_screen/items/model/item_response.dart';

class ItemRepository {
  final NetworkService networkService;

  ItemRepository({required this.networkService});

  Future<ItemResponse> getAllItems() async {
    final response = await networkService.get(
      ApiConstants.getAllItemsEnd,
      null,
      null,
    );
    return ItemResponse.fromJson(response);
  }
}
