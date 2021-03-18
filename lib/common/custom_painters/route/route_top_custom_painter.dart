import 'package:flutter/material.dart';

import 'route_custom_painter_base.dart';

class RouteTopCustomPainter extends RouteCustomPainterBase {
  const RouteTopCustomPainter({
    Color indicatorColor,
    Color connectorColor,
  }) : super(
          indicatorColor: indicatorColor,
          connectorColor: connectorColor,
        );

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    Path connectorBottomPath = Path();
    connectorBottomPath.moveTo(size.width * 0.4000000, size.height * 0.7000000);
    connectorBottomPath.lineTo(size.width * 0.4000000, size.height);
    connectorBottomPath.lineTo(size.width * 0.6000000, size.height);
    connectorBottomPath.lineTo(size.width * 0.6000000, size.height * 0.7000000);
    connectorBottomPath.lineTo(size.width * 0.4000000, size.height * 0.7000000);
    connectorBottomPath.close();

    canvas.drawPath(connectorBottomPath, connectorPaint);

    Path indicatorPath = Path();
    indicatorPath.moveTo(size.width * 0.4993954, size.height * 0.2546522);
    indicatorPath.cubicTo(
        size.width * 0.6954000,
        size.height * 0.2547500,
        size.width * 0.9894000,
        size.height * 0.3234000,
        size.width * 0.9891233,
        size.height * 0.4995162);
    indicatorPath.cubicTo(
        size.width * 0.9894000,
        size.height * 0.5974000,
        size.width * 0.8423000,
        size.height * 0.7444000,
        size.width * 0.4993954,
        size.height * 0.7443801);
    indicatorPath.cubicTo(
        size.width * 0.3043000,
        size.height * 0.7444000,
        size.width * 0.0098000,
        size.height * 0.6709000,
        size.width * 0.0096675,
        size.height * 0.4995162);
    indicatorPath.cubicTo(
        size.width * 0.0098000,
        size.height * 0.4017500,
        size.width * 0.1566000,
        size.height * 0.2547500,
        size.width * 0.4993954,
        size.height * 0.2546522);
    indicatorPath.close();

    canvas.drawPath(indicatorPath, indicatorPaint);
  }
}
