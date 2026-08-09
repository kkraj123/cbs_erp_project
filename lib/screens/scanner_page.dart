import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );
  bool _hasPopped = false;

  void _onDetect(BarcodeCapture capture) {
    if (_hasPopped) return;
    final barcode = capture.barcodes.firstOrNull;
    final value = barcode?.rawValue;
    if (value != null && value.isNotEmpty) {
      _hasPopped = true;
      Navigator.pop(context, value);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Scanner'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, state, child) {
                return Icon(
                  state.torchState == TorchState.on
                      ? Icons.flash_on
                      : Icons.flash_off,
                );
              },
            ),
            onPressed: () => controller.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => controller.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: controller,
            onDetect: _onDetect,
            errorBuilder: (context, error) {
              return _buildErrorState(error);
            },
            placeholderBuilder: (context) {
              return const Center(child: CircularProgressIndicator());
            },
          ),
          IgnorePointer(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final scanRect = _scanWindow(constraints.biggest);
                return CustomPaint(
                  size: constraints.biggest,
                  painter: _ScannerOverlayPainter(scanRect: scanRect),
                );
              },
            ),
          ),
          // Hint text below the cutout.
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: const Text(
              'Align the code within the frame',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Rect _scanWindow(Size screenSize) {
    final width = screenSize.width * 0.75;
    const aspectRatio = 1.0;
    final height = width / aspectRatio;
    final center = Offset(screenSize.width / 2, screenSize.height / 2);
    return Rect.fromCenter(center: center, width: width, height: height);
  }

  Widget _buildErrorState(MobileScannerException error) {
    String message;
    switch (error.errorCode) {
      case MobileScannerErrorCode.permissionDenied:
        message =
            'Camera permission was denied.\nEnable it in system settings.';
        break;
      case MobileScannerErrorCode.unsupported:
        message = 'This device does not support camera scanning.';
        break;
      default:
        message =
            'Camera error: ${error.errorDetails?.message ?? error.errorCode}';
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.no_photography, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.start(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  _ScannerOverlayPainter({required this.scanRect});

  final Rect scanRect;

  static const _borderRadius = 16.0;
  static const _borderColor = Colors.white;
  static const _borderWidth = 3.0;
  static const _cornerLength = 28.0;
  static const _overlayColor = Color(0xB2000000); // black w/ ~70% opacity

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(scanRect, const Radius.circular(_borderRadius)),
      );

    final overlayPath = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    canvas.drawPath(overlayPath, Paint()..color = _overlayColor);

    final cornerPaint = Paint()
      ..color = _borderColor
      ..strokeWidth = _borderWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final r = scanRect;

    canvas.drawPath(
      Path()
        ..moveTo(r.left, r.top + _cornerLength)
        ..lineTo(r.left, r.top + _borderRadius)
        ..arcToPoint(
          Offset(r.left + _borderRadius, r.top),
          radius: const Radius.circular(_borderRadius),
        )
        ..lineTo(r.left + _cornerLength, r.top),
      cornerPaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(r.right - _cornerLength, r.top)
        ..lineTo(r.right - _borderRadius, r.top)
        ..arcToPoint(
          Offset(r.right, r.top + _borderRadius),
          radius: const Radius.circular(_borderRadius),
        )
        ..lineTo(r.right, r.top + _cornerLength),
      cornerPaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(r.left, r.bottom - _cornerLength)
        ..lineTo(r.left, r.bottom - _borderRadius)
        ..arcToPoint(
          Offset(r.left + _borderRadius, r.bottom),
          radius: const Radius.circular(_borderRadius),
          clockwise: false,
        )
        ..lineTo(r.left + _cornerLength, r.bottom),
      cornerPaint,
    );
    // Bottom-right
    canvas.drawPath(
      Path()
        ..moveTo(r.right - _cornerLength, r.bottom)
        ..lineTo(r.right - _borderRadius, r.bottom)
        ..arcToPoint(
          Offset(r.right, r.bottom - _borderRadius),
          radius: const Radius.circular(_borderRadius),
          clockwise: false,
        )
        ..lineTo(r.right, r.bottom - _cornerLength),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScannerOverlayPainter oldDelegate) =>
      oldDelegate.scanRect != scanRect;
}
