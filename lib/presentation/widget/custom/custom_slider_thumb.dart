import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../constant/service_api_constant.dart';



class CircleSliderThumbShape extends SliderComponentShape {
  final double radius;
  final double elevation;
  final double pressedElevation;
  final Color color;
  final String tooltipText;

  const CircleSliderThumbShape({
    this.radius = 10.0,
    this.elevation = 1.0,
    this.pressedElevation = 6.0,
    this.color = Colors.blue,
    required this.tooltipText,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(radius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final canvas = context.canvas;

    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    final Color color = colorTween.evaluate(enableAnimation)!;

    final Tween<double> elevationTween = Tween<double>(
      begin: elevation,
      end: pressedElevation,
    );

    final double evaluatedElevation = elevationTween.evaluate(activationAnimation);

    final Path path = Path()
      ..addArc(Rect.fromCircle(center: center, radius: radius), 0, math.pi * 2);

    canvas.drawShadow(path, Colors.black, evaluatedElevation, true);

    canvas.drawCircle(center, radius, Paint()..color = color);

    // Draw tooltip background
    final tooltipPaint = Paint()..color = green; // Background color for tooltip

    final double textWidth = labelPainter.width + 8.0;
    final double textHeight = labelPainter.height + 12.0;
    final double tooltipWidth = textWidth;
    final double tooltipHeight = textHeight + 6.0; // Height of the tooltip background
    final double tooltipTipWidth = 12.0; // Width of the triangular tip
    final double tooltipTipHeight = 6.0; // Height of the triangular tip

    final Rect tooltipRect = Rect.fromLTWH(
      center.dx - tooltipWidth / 2,
      center.dy - radius * 2 - tooltipHeight - tooltipTipHeight+10,
      tooltipWidth,
      tooltipHeight-5,
    );

    final Path tooltipPath = Path()
      ..moveTo(tooltipRect.left, tooltipRect.bottom)
      ..lineTo(tooltipRect.left + tooltipRect.width / 2 - tooltipTipWidth / 2, tooltipRect.bottom)
      ..lineTo(tooltipRect.left + tooltipRect.width / 2, tooltipRect.bottom + tooltipTipHeight)
      ..lineTo(tooltipRect.left + tooltipRect.width / 2 + tooltipTipWidth / 2, tooltipRect.bottom)
      ..lineTo(tooltipRect.right, tooltipRect.bottom)
      ..lineTo(tooltipRect.right, tooltipRect.top)
      ..lineTo(tooltipRect.left, tooltipRect.top)
      ..close();

    canvas.drawPath(tooltipPath, tooltipPaint);

    // Draw tooltip text
    final textOffset = Offset(
      center.dx - textWidth / 2+4,
      center.dy - radius * 2 - textHeight - tooltipTipHeight / 2+8,
    );
    labelPainter.paint(canvas, textOffset);
  }
}
