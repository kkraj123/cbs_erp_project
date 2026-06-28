// lib/core/network/network_events_stub.dart

import 'dart:async';

StreamSubscription<bool>? listenToNetworkEvents(
    void Function(bool isOnline) onChanged) {
  return null; // no-op on mobile/desktop
}