import 'package:flutter/material.dart';

abstract class RouteCustomPainterBase extends CustomPainter {
  final Color? indicatorColor;
  final Color? connectorColor;

  const RouteCustomPainterBase({
    required this.indicatorColor,
    required this.connectorColor,
  });

  Paint get indicatorPaint => Paint()
    ..color = indicatorColor ?? Colors.black
    ..style = PaintingStyle.fill
    ..strokeWidth = 1;
  Paint get connectorPaint => Paint()
    ..color = connectorColor ?? Colors.black
    ..style = PaintingStyle.fill
    ..strokeWidth = 1;

  void paint(
    Canvas canvas,
    Size size,
  );

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
