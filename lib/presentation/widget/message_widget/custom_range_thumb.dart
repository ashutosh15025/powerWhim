import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../constant/service_api_constant.dart';


class IndicatorRangeSliderThumbShape<T> extends RangeSliderThumbShape {
  IndicatorRangeSliderThumbShape(this.start, this.end);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(15, 40);
  }
  T start;
  T end;
  late TextPainter labelTextPainter = TextPainter()
    ..textDirection = TextDirection.ltr;
  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        bool? isDiscrete,
        bool? isEnabled,
        bool? isOnTop,
        TextDirection? textDirection,
        required SliderThemeData sliderTheme,
        Thumb? thumb,
        bool? isPressed,
      }) {
    final canvas = context.canvas;

    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    final Color color = colorTween.evaluate(enableAnimation)!;

   double radius = 12;

    final Path path = Path()
      ..addArc(Rect.fromCircle(center: center, radius: radius), 0, math.pi * 2);

    canvas.drawCircle(center, radius, Paint()..color = color);

    // Draw tooltip background
    final tooltipPaint = Paint()..color = green; // Background color for tooltip

    final double textWidth = 40.0;
    final double textHeight = 28.0;
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
    if (thumb == null) {
      return;
    }
    final value = thumb == Thumb.start ? start : end;
    labelTextPainter.text = TextSpan(
        text: value.toString(),
        style: const TextStyle(fontSize: 14, color: Colors.white));
    labelTextPainter.layout();
    labelTextPainter.paint(
        canvas,
        center.translate(
            (labelTextPainter.width / 2) -(labelTextPainter.width), center.dy - radius * 2 - tooltipHeight - tooltipTipHeight-5));
  }
}
