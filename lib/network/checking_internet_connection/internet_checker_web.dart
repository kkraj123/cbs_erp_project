// lib/core/network/internet_checker_web.dart

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:http/http.dart' as http;

Future<bool> checkInternet() async {
  // Step 1: Check browser's built-in online status first (instant, no CORS)
  if (!html.window.navigator.onLine!) {
    return false;
  }

  // Step 2: Verify with a real request to a CORS-friendly endpoint
  try {
    final response = await http
        .get(Uri.parse('https://cloudflare.com/cdn-cgi/trace'))
        .timeout(const Duration(seconds: 5));
    return response.statusCode == 200;
  } catch (_) {
    // If fetch fails but navigator says online, trust navigator
    return html.window.navigator.onLine ?? false;
  }
}