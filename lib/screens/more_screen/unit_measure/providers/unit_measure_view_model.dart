import 'package:cbs_erp_project/network/core/errors/app_exception.dart';
import 'package:cbs_erp_project/network/core/network/api_state.dart';
import 'package:cbs_erp_project/screens/more_screen/unit_measure/model/uni_save_response.dart';
import 'package:cbs_erp_project/screens/more_screen/unit_measure/model/unit_measure_response_model.dart';
import 'package:cbs_erp_project/screens/more_screen/unit_measure/providers/unit_measure_repo.dart';
import 'package:cbs_erp_project/screens/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnitMeasureViewModel
    extends StateNotifier<ApiState<UnitMeasureResponseModel>> {
  final UnitMeasureRepo unitMeasureRepo;

  UnitMeasureViewModel({required this.unitMeasureRepo})
    : super(ApiState.initial());

  Future<void> getAllUnitMeasureItems() async {
    state = ApiState.loading();
    try {
      final unitMeasureResponse = await unitMeasureRepo.getUnitMeasureItems();
      if (unitMeasureResponse.success == true &&
          unitMeasureResponse.data != null) {
        state = ApiState.success(unitMeasureResponse);
      }
    } on AppException catch (e) {
      state = ApiState.error(e.message);
    } catch (e) {
      state = ApiState.error(e.toString());
    }
  }
}

final unitMeasureProvider = Provider<UnitMeasureRepo>((ref) {
  return UnitMeasureRepo(networkService: ref.watch(networkServiceProvider));
});

final getUnitMeasureProvider =
    StateNotifierProvider<
      UnitMeasureViewModel,
      ApiState<UnitMeasureResponseModel>
    >((ref) {
      return UnitMeasureViewModel(
        unitMeasureRepo: ref.watch(unitMeasureProvider),
      );
    });

class SaveUnitViewModel extends StateNotifier<ApiState<UniSaveResponse>> {
  final UnitMeasureRepo unitMeasureRepo;

  SaveUnitViewModel({required this.unitMeasureRepo})
    : super(ApiState.initial());

  Future<void> saveUnitMeasureItem(Map<String, dynamic> bodyParams) async {
    state = ApiState.loading();
    try {
      final saveUnitMeasure = await unitMeasureRepo.saveUnitMeasure(bodyParams);
      state = ApiState.success(saveUnitMeasure);
    } on AppException catch (e) {
      state = ApiState.error(e.message);
    } catch (e) {
      state = ApiState.error(e.toString());
    }
  }
}

final unitSaveMeasureProvider = Provider<UnitMeasureRepo>((ref) {
  return UnitMeasureRepo(networkService: ref.watch(networkServiceProvider));
});

final saveUnitMeasureProvider =
    StateNotifierProvider<SaveUnitViewModel, ApiState<UniSaveResponse>>((ref) {
      return SaveUnitViewModel(
        unitMeasureRepo: ref.watch(unitSaveMeasureProvider),
      );
    });
