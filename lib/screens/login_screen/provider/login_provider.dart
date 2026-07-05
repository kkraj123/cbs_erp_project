

import 'package:cbs_erp_project/network/core/network/network_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final baseUrlProvider = StateProvider<String>((ref) => '');


final networkServiceProvider = Provider<NetworkService>((ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  return NetworkService(baseUrl);
});