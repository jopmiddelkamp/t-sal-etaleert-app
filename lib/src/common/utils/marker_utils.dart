import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerUtils {
  static Future<BitmapDescriptor> getMarkerIcon({
    required Future<ui.Image> Function() imageResolver,
    required Size size,
    required Color shadowColor,
  }) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);

    final radius = Radius.circular(size.width / 2);

    final shadowPaint = Paint()..color = shadowColor.withAlpha(100);
    final shadowWidth = 15.0;

    final borderPaint = Paint()..color = Colors.white;
    final borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
          0.0,
          0.0,
          size.width,
          size.height,
        ),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      shadowPaint,
    );

    // Add border circle
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
          shadowWidth,
          shadowWidth,
          size.width - (shadowWidth * 2),
          size.height - (shadowWidth * 2),
        ),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      borderPaint,
    );

    // Oval for the image
    Rect oval = Rect.fromLTWH(
      imageOffset,
      imageOffset,
      size.width - (imageOffset * 2),
      size.height - (imageOffset * 2),
    );

    // Add path for oval image
    canvas.clipPath(Path()..addOval(oval));

    // Add image
    ui.Image image = await imageResolver();
    paintImage(
      canvas: canvas,
      image: image,
      rect: oval,
      fit: BoxFit.fitWidth,
    );

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(
          size.width.toInt(),
          size.height.toInt(),
        );

    // Convert image to bytes
    final ByteData? byteData = await markerAsImage.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }
}
