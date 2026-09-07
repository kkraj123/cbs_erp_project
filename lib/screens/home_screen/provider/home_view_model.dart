import 'package:cbs_erp_project/network/core/errors/app_exception.dart';
import 'package:cbs_erp_project/network/core/network/api_state.dart';
import 'package:cbs_erp_project/screens/home_screen/model/category_item_by_logic.dart';
import 'package:cbs_erp_project/screens/home_screen/model/item_save_model.dart';
import 'package:cbs_erp_project/screens/home_screen/model/unit_reponse.dart';
import 'package:cbs_erp_project/screens/home_screen/provider/home_repo.dart';
import 'package:cbs_erp_project/screens/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends StateNotifier<ApiState<CategoryItemsByLogic>> {
  final HomeRepo homeRepo;

  HomeViewModel({required this.homeRepo}) : super(ApiState.initial());

  Future<void> getCategoryDropDownItems() async {
    state = ApiState.loading();
    try {
      final categoryDropDownItems = await homeRepo
          .getCategoryItemsForDropdown();
      if (categoryDropDownItems.success == true &&
          categoryDropDownItems.data != null) {
        state = ApiState.success(categoryDropDownItems);
      }
    } on AppException catch (e) {
      state = ApiState.error(e.message);
    } catch (e) {
      state = ApiState.error(e.toString());
    }
  }
}

final categoryProvider = Provider<HomeRepo>((ref) {
  return HomeRepo(networkService: ref.watch(networkServiceProvider));
});

final getAllCategoryItemsForDropDown =
    StateNotifierProvider<HomeViewModel, ApiState<CategoryItemsByLogic>>((ref) {
      return HomeViewModel(homeRepo: ref.watch(categoryProvider));
    });

class SaveItemModel extends StateNotifier<ApiState<ItemSaveResponse>> {
  final HomeRepo homeRepo;

  SaveItemModel({required this.homeRepo}) : super(ApiState.initial());

  Future<void> saveItem(Map<String, dynamic> bodyParams) async {
    state = ApiState.loading();
    try {
      final saveItemResponse = await homeRepo.saveItems(bodyParams);
      state = ApiState.success(saveItemResponse);
    } on AppException catch (e) {
      state = ApiState.error(e.message);
    } catch (e) {
      state = ApiState.error(e.toString());
    }
  }
}

final saveItemProvider = Provider<HomeRepo>((ref) {
  return HomeRepo(networkService: ref.watch(networkServiceProvider));
});

final saveItem =
    StateNotifierProvider<SaveItemModel, ApiState<ItemSaveResponse>>((ref) {
      return SaveItemModel(homeRepo: ref.watch(saveItemProvider));
    });

class UnitViewModel extends StateNotifier<ApiState<UnitResponse>> {
  final HomeRepo homeRepo;

  UnitViewModel({required this.homeRepo}) : super(ApiState.initial());

  Future<void> getUnits() async {
    state = ApiState.loading();
    try {
      final unitResponse = await homeRepo.getUnits();
      if (unitResponse.success == true && unitResponse.data != null) {
        state = ApiState.success(unitResponse);
      }
    } on AppException catch (e) {
      state = ApiState.error(e.message);
    } catch (e) {
      state = ApiState.error(e.toString());
    }
  }
}

final unitProvider = Provider<HomeRepo>((ref) {
  return HomeRepo(networkService: ref.watch(networkServiceProvider));
});

final getUnitItems =
    StateNotifierProvider<UnitViewModel, ApiState<UnitResponse>>((ref) {
      return UnitViewModel(homeRepo: ref.watch(unitProvider));
    });
