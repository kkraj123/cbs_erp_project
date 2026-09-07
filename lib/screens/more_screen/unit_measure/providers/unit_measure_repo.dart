import 'package:cbs_erp_project/network/core/network/api_constants.dart';
import 'package:cbs_erp_project/network/core/network/network_service.dart';
import 'package:cbs_erp_project/screens/more_screen/unit_measure/model/uni_save_response.dart';
import 'package:cbs_erp_project/screens/more_screen/unit_measure/model/unit_measure_response_model.dart';

class UnitMeasureRepo {
  final NetworkService networkService;

  UnitMeasureRepo({required this.networkService});

  Future<UnitMeasureResponseModel> getUnitMeasureItems() async {
    final response = await networkService.get(ApiConstants.unitMeasureEndpoint, null, null);
    return UnitMeasureResponseModel.fromJson(response);
  }
  Future<UniSaveResponse> saveUnitMeasure(Map<String, dynamic> bodyParams) async {
    final response = await networkService.post(ApiConstants.saveUnitMeasureEndPoint, null, null, bodyParams);
    return UniSaveResponse.fromJson(response);
  }
}
