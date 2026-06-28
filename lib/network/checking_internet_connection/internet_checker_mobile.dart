// lib/core/network/internet_checker_mobile.dart

import 'dart:io';

Future<bool> checkInternet() async {
  try {
    final socket = await Socket.connect(
      '8.8.8.8',
      53,
      timeout: const Duration(seconds: 3),
    );
    socket.destroy();
    return true;
  } on SocketException {
    return false;
  } catch (_) {
    return false;
  }
}