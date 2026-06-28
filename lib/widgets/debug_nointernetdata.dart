// Temporary debug widget — remove after testing
import 'package:cbs_erp_project/network/checking_internet_connection/connectivity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkDebugBanner extends ConsumerWidget {
  const NetworkDebugBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(networkStatusProvider);
    final isConnected = status == NetworkStatus.connected;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6),
      color: isConnected ? Colors.green : Colors.red,
      child: Text(
        isConnected ? '✅ CONNECTED' : '❌ DISCONNECTED',
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}