import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class BarcodeDetectorPainter extends CustomPainter {
  BarcodeDetectorPainter(
    this.barcodes,
    this.absoluteImageSize,
    this.rotation,
  );

  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    debugPrint('Painting barcodes...');
    debugPrint('Canvas size: $size');
    debugPrint('Image size: $absoluteImageSize');

    for (final Barcode barcode in barcodes) {
      final boundingBox = barcode.boundingBox;
      if (boundingBox != null) {
        final double scaleX = size.width / absoluteImageSize.height;
        final double scaleY = size.height / absoluteImageSize.width;

        final rect = Rect.fromLTRB(
          boundingBox.bottom * scaleX,
          boundingBox.left * scaleY,
          boundingBox.top * scaleX,
          boundingBox.right * scaleY,
        );

        debugPrint('Drawing rect: $rect');
        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
