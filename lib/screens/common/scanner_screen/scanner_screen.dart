import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/AppScaffold/app_scaffold.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  late CameraController _controller;
  bool _isDetecting = false;
  final BarcodeScanner _barcodeScanner =
      BarcodeScanner(formats: [BarcodeFormat.qrCode, BarcodeFormat.dataMatrix]);
  List<Barcode> _barcodes = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
    );
    await _controller.initialize();
    _controller.startImageStream(_processCameraImage);
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isDetecting) return;
    _isDetecting = true;

    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    // Comentamos esta sección problemática
    /*
    final InputImageRotation imageRotation =
        InputImageRotation.fromRawValue(
                _controller.description.sensorOrientation) ??
            InputImageRotation.rotation0deg;

    final inputImageData = InputImage(
      size: Size(image.width.toDouble(), image.height.toDouble()),
      imageRotation: imageRotation,
      inputImageFormat:
          InputImageFormatMethods.fromRawValue(image.format.raw) ??
              InputImageFormat.nv21,
      planeData: image.planes.map((Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      }).toList(),
    );
    */
    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation
            .rotation0deg, // Ajusta la rotación según tus necesidades
        format:
            InputImageFormat.nv21, // Ajusta el formato según tus necesidades
        bytesPerRow: image.planes[0].bytesPerRow,
      ),
    );

    final barcodes = await _barcodeScanner.processImage(inputImage);
    setState(() {
      _barcodes = barcodes;
    });

    _isDetecting = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Stack(
        children: [
          CameraPreview(_controller),
          CustomPaint(
            painter: BarcodePainter(barcodes: _barcodes),
          ),
        ],
      ),
      appBarTitle: 'Scanner Screen',
      isProtected: false,
    );
  }
}

class BarcodePainter extends CustomPainter {
  final List<Barcode> barcodes;

  BarcodePainter({required this.barcodes});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;

    for (final barcode in barcodes) {
      final rect = barcode.boundingBox!;
      final rotation = barcode.cornerPoints!.length == 4
          ? math.atan2(barcode.cornerPoints![3].y - barcode.cornerPoints![0].y,
              barcode.cornerPoints![3].x - barcode.cornerPoints![0].x)
          : 0.0;

      canvas.save();
      canvas.translate(rect.center.dx, rect.center.dy);
      canvas.rotate(rotation);
      canvas.translate(-rect.center.dx, -rect.center.dy);

      canvas.drawRect(rect, paint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
