import 'package:cbs_erp_project/network/core/network/api_constants.dart';
import 'package:cbs_erp_project/network/core/network/network_service.dart';
import 'package:cbs_erp_project/screens/more_screen/unit_measure/model/unit_measure_response_model.dart';

class UnitMeasureRepo {
  final NetworkService networkService;

  UnitMeasureRepo({required this.networkService});

  Future<UnitMeasureResponseModel> getUnitMeasureItems() async {
    final response = await networkService.get(ApiConstants.unitMeasureEndpoint, null, null);
    return UnitMeasureResponseModel.fromJson(response);
  }
}
