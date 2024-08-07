import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

import '../../../widgets/AppScaffold/app_scaffold.dart';
import 'barcode_detector_painter.dart';

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
  Size? _imageSize;

  @override
  void initState() {
    super.initState();
    debugPrint('Initializing camera...');
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    debugPrint('Cameras available: ${cameras.length}');
    _controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
    );
    await _controller.initialize();
    _controller.startImageStream(_processCameraImage);
    debugPrint('Camera initialized');
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isDetecting) return;
    _isDetecting = true;
    debugPrint('Processing camera image...');

    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation0deg,
        format: InputImageFormat.nv21,
        bytesPerRow: image.planes[0].bytesPerRow,
      ),
    );

    // debugPrint('Input image created: ${inputImage.metadata}');
    List<Barcode> barcodes = await _barcodeScanner.processImage(inputImage);

    if (barcodes.isNotEmpty) {
      // debugPrint('Barcodes detected: ${barcodes.length}');
      for (var barcode in barcodes) {
        // debugPrint('Barcode bounding box: ${barcode.boundingBox}');
        // debugPrint('Barcode corner points: ${barcode.cornerPoints}');
      }
    } else {
      // debugPrint('No barcodes detected');
    }

    setState(() {
      _barcodes = barcodes;
      _imageSize = Size(image.width.toDouble(), image.height.toDouble());
    });

    _isDetecting = false;
    // debugPrint('Processing done');
  }

  @override
  void dispose() {
    _controller.dispose();
    _barcodeScanner.close();
    super.dispose();
    // debugPrint('Disposed resources');
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return AppScaffold(
      body: Stack(
        children: [
          CameraPreview(_controller),
          if (_imageSize != null)
            Positioned.fill(
              child: CustomPaint(
                painter: BarcodeDetectorPainter(
                    _barcodes, _imageSize!, InputImageRotation.rotation0deg),
              ),
            ),
        ],
      ),
      appBarTitle: 'Scanner Screen',
      isProtected: false,
    );
  }
}
