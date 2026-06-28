// lib/core/network/connectivity_provider.dart

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'internet_checker_stub.dart'
if (dart.library.io) 'internet_checker_mobile.dart'
if (dart.library.html) 'internet_checker_web.dart';

// Web-only browser event listener
import 'network_events_stub.dart'
if (dart.library.html) 'network_events_web.dart';

enum NetworkStatus { connected, disconnected }

class NetworkNotifier extends StateNotifier<NetworkStatus> {
  NetworkNotifier() : super(NetworkStatus.connected) {
    _init();
  }

  StreamSubscription? _connectivitySub;
  StreamSubscription? _browserEventSub;
  Timer? _pollingTimer;
  bool _isChecking = false;

  Future<void> _init() async {
    await _verifyActualInternet();

    // 1. Browser online/offline events (web only — instant)
    _browserEventSub = listenToNetworkEvents((isOnline) async {
      debugPrint('🌐 Browser event: ${isOnline ? "online" : "offline"}');
      if (!isOnline) {
        state = NetworkStatus.disconnected;
      } else {
        await _verifyActualInternet();
      }
    });

    // 2. connectivity_plus stream (mobile)
    _connectivitySub = Connectivity().onConnectivityChanged.listen(
          (List<ConnectivityResult> results) async {
        debugPrint('🌐 Connectivity changed: $results');
        final hasInterface = results.any((r) => r != ConnectivityResult.none);
        if (!hasInterface) {
          state = NetworkStatus.disconnected;
        } else {
          await _verifyActualInternet();
        }
      },
    );

    // 3. Polling fallback every 5 seconds
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      await _verifyActualInternet();
    });
  }

  Future<void> _verifyActualInternet() async {
    if (_isChecking) return;
    _isChecking = true;

    try {
      final isConnected = await checkInternet();
      final newStatus =
      isConnected ? NetworkStatus.connected : NetworkStatus.disconnected;

      if (state != newStatus) {
        debugPrint(isConnected ? '✅ CONNECTED' : '❌ DISCONNECTED');
        state = newStatus;
      }
    } catch (e) {
      debugPrint('❌ Check error: $e');
      if (state != NetworkStatus.disconnected) {
        state = NetworkStatus.disconnected;
      }
    } finally {
      _isChecking = false;
    }
  }

  @override
  void dispose() {
    _connectivitySub?.cancel();
    _browserEventSub?.cancel();
    _pollingTimer?.cancel();
    super.dispose();
  }
}

final networkStatusProvider =
StateNotifierProvider<NetworkNotifier, NetworkStatus>(
      (ref) => NetworkNotifier(),
);

final isConnectedProvider = Provider<bool>((ref) {
  return ref.watch(networkStatusProvider) == NetworkStatus.connected;
});