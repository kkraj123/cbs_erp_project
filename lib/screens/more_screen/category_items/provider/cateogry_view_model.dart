import 'package:cbs_erp_project/network/core/errors/app_exception.dart';
import 'package:cbs_erp_project/network/core/network/api_state.dart';
import 'package:cbs_erp_project/screens/home_screen/model/category_item_by_logic.dart';
import 'package:cbs_erp_project/screens/more_screen/category_items/model/CategorySaveItemResponse.dart';
import 'package:cbs_erp_project/screens/more_screen/category_items/model/CategryItems.dart';
import 'package:cbs_erp_project/screens/more_screen/category_items/provider/category_repo.dart';
import 'package:cbs_erp_project/screens/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryViewModel extends StateNotifier<ApiState<CategoryItemsResponse>> {
  final CategoryRepo categoryRepo;

  CategoryViewModel({required this.categoryRepo}) : super(ApiState.initial());

  getCategoryItemsType() async {
    state = ApiState.loading();
    try {
      final itemsTypesResponse = await categoryRepo.getCategoryItems();
      state = ApiState.success(itemsTypesResponse);
    } on AppException catch (e) {
      state = ApiState.error(e.message);
    } catch (e) {
      state = ApiState.error(e.toString());
    }
  }
}

final items = Provider<CategoryRepo>((ref) {
  return CategoryRepo(networkService: ref.watch(networkServiceProvider));
});
final itemsTypeProvider =
    StateNotifierProvider<CategoryViewModel, ApiState<CategoryItemsResponse>>((
      ref,
    ) {
      return CategoryViewModel(categoryRepo: ref.watch(items));
    });

class SaveCategoryVM extends StateNotifier<ApiState<CategorySaveItemResponse>> {
  final CategoryRepo categoryRepo;

  SaveCategoryVM({required this.categoryRepo}) : super(ApiState.initial());

  saveCategoryItem(Map<String, dynamic> bodyParams) async {
    state = ApiState.loading();
    try {
      final saveItemResponse = await categoryRepo.saveCategoryItems(bodyParams);
      state = ApiState.success(saveItemResponse);
    } on AppException catch (e) {
      state = ApiState.error(e.message);
    } catch (e) {
      state = ApiState.error(e.toString());
    }
  }
}

final saveItems = Provider<CategoryRepo>((ref) {
  return CategoryRepo(networkService: ref.watch(networkServiceProvider));
});
final saveCategoryProvider =
    StateNotifierProvider<SaveCategoryVM, ApiState<CategorySaveItemResponse>>((
      ref,
    ) {
      return SaveCategoryVM(categoryRepo: ref.watch(saveItems));
    });

class CategoryByLogicViewModel
    extends StateNotifier<ApiState<CategoryItemsByLogic>> {
  final CategoryRepo categoryRepo;

  CategoryByLogicViewModel({required this.categoryRepo})
    : super(ApiState.loading());

  getCategoryByLogicItems() async {
    state = ApiState.loading();
    try {
      final categoryByLogicResponse = await categoryRepo.getCategoryByLogic();
      state = ApiState.success(categoryByLogicResponse);
    } on AppException catch (e) {
      state = ApiState.error(e.message);
    } catch (e) {
      state = ApiState.error(e.toString());
    }
  }
}

final categoryByLogic = Provider<CategoryRepo>((ref) {
  return CategoryRepo(networkService: ref.watch(networkServiceProvider));
});
final categoryByLogicProvider =
    StateNotifierProvider<
      CategoryByLogicViewModel,
      ApiState<CategoryItemsByLogic>
    >((ref) {
      return CategoryByLogicViewModel(categoryRepo: ref.watch(saveItems));
    });
