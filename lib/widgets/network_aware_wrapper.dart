// lib/core/network/network_aware_wrapper.dart

import 'package:cbs_erp_project/custom_widgets/internet_info_dialog.dart';
import 'package:cbs_erp_project/network/checking_internet_connection/connectivity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class NetworkAwareWrapper extends ConsumerStatefulWidget {
  final Widget child;
  const NetworkAwareWrapper({super.key, required this.child});

  @override
  ConsumerState<NetworkAwareWrapper> createState() =>
      _NetworkAwareWrapperState();
}

class _NetworkAwareWrapperState extends ConsumerState<NetworkAwareWrapper> {
  bool _isDialogShowing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final status = ref.read(networkStatusProvider);
      if (status == NetworkStatus.disconnected) {
        _showNoInternetDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<NetworkStatus>(networkStatusProvider, (previous, next) {
      if (next == NetworkStatus.disconnected && !_isDialogShowing) {
        _showNoInternetDialog();
      } else if (next == NetworkStatus.connected && _isDialogShowing) {
        _dismissDialog();
      }
    });
    return widget.child;
  }

  void _showNoInternetDialog() {
    if (_isDialogShowing || !context.mounted) return;
    _isDialogShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => NoInternetDialog(
        onRetry: () {
          // Manual retry triggers an immediate check
          ref.read(networkStatusProvider.notifier);
        },
      ),
    ).then((_) => _isDialogShowing = false);
  }

  void _dismissDialog() {
    if (!_isDialogShowing || !context.mounted) return;
    Navigator.of(context, rootNavigator: true).pop();
    _isDialogShowing = false;
    _showBackOnlineSnackbar();
  }

  void _showBackOnlineSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.wifi_rounded, color: Colors.white, size: 18),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Back online',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Your connection has been restored.',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}