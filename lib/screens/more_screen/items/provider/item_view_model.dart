import 'package:cbs_erp_project/network/core/errors/app_exception.dart';
import 'package:cbs_erp_project/network/core/network/api_state.dart';
import 'package:cbs_erp_project/screens/more_screen/items/model/item_response.dart';
import 'package:cbs_erp_project/screens/more_screen/items/provider/item_repository.dart';
import 'package:cbs_erp_project/screens/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemViewModel extends StateNotifier<ApiState<ItemResponse>> {
  final ItemRepository itemRepository;

  ItemViewModel({required this.itemRepository}) : super(ApiState.initial());

  Future<void> getAllItems() async {
    state = ApiState.loading();
    try {
      final allItemResponse = await itemRepository.getAllItems();
      if (allItemResponse.success == true && allItemResponse.data != null) {
        state = ApiState.success(allItemResponse);
      }
    } on AppException catch (e) {
      state = ApiState.error(e.message);
    } catch (e) {
      state = ApiState.error(e.toString());
    }
  }
}

final authRepositoryProvider = Provider<ItemRepository>((ref) {
  return ItemRepository(networkService: ref.watch(networkServiceProvider));
});

final getAllItemsModelProvider =
    StateNotifierProvider<ItemViewModel, ApiState<ItemResponse>>((ref) {
      return ItemViewModel(itemRepository: ref.watch(authRepositoryProvider));
    });
