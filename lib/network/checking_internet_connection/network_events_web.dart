// lib/core/network/network_events_web.dart

import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

StreamSubscription<bool>? listenToNetworkEvents(
    void Function(bool isOnline) onChanged) {
  final controller = StreamController<bool>.broadcast();

  // Browser fires these instantly when network changes
  html.window.onOnline.listen((_) => controller.add(true));
  html.window.onOffline.listen((_) => controller.add(false));

  return controller.stream.listen(onChanged);
}