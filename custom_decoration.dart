import 'package:flutter/material.dart';
import 'package:qurany/resources/app_colors.dart';

import '../resources/app_constants.dart';

/*
Create a CustomDecoration class that implements the Decoration abstract class.
 */
class CustomDecoration extends Decoration {
  const CustomDecoration(this._patternLength, this._patternColor);
/*
Create a constructor that accepts a double value which is the length of the pattern you will draw.
 */
  final double _patternLength;

  final Color _patternColor;

  /*
  Create an instance of the _CustomDecorationPainter and pass the _patternLength parameter, you will create this class in the next section.
   */
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomDecorationPainter(_patternLength,_patternColor);
  }
}

class _CustomDecorationPainter extends BoxPainter {
  _CustomDecorationPainter(this._patternLength, this._patternColor);

  final double _patternLength;
  final Color _patternColor;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect bounds = offset & configuration.size!;
    _drawDecoration(canvas, bounds);
  }

  void _drawDecoration(Canvas canvas, Rect bounds) {
    Paint innerPaint = Paint()..color = _patternColor;
    Paint outerPaint = Paint()
      ..color = AppColors.FrameOuter
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppConstants.strokeWidthFrame;

    Path innerPath = Path();
    Path outerPath = Path();

    _addVerticalSides(bounds, innerPath, outerPath);
    _addHorizontalSides(bounds, innerPath, outerPath);

    canvas.drawPath(innerPath, innerPaint);
    canvas.drawPath(outerPath, outerPaint);
  }

  void _addVerticalSides(Rect bounds, Path innerPath, Path outerPath) {
    int patternsCount = bounds.height  ~/ _patternLength;
    double _accurateLength = bounds.height / patternsCount ;

    for (var i = 0; i < patternsCount; ++i) {
      Rect leftSidePatternRect = Rect.fromLTWH(
        bounds.left,
        bounds.top + (i * _accurateLength),
        _accurateLength,
        _accurateLength,
      );

      Rect rightSidePatternRect = Rect.fromLTWH(
        bounds.right - _accurateLength,
        bounds.top + (i * _accurateLength),
        _accurateLength,
        _accurateLength,
      );

      innerPath.addRotatedRect(leftSidePatternRect);
      outerPath.addRect(leftSidePatternRect);

      innerPath.addRotatedRect(rightSidePatternRect);
      outerPath.addRect(rightSidePatternRect);
    }
  }

  void _addHorizontalSides(Rect bounds, Path innerPath, Path outerPath) {
    int patternsCount = bounds.width ~/ _patternLength;

    double _accurateLength = (bounds.width / patternsCount);

    for (var i = 0; i < patternsCount; ++i) {
      Rect topSidePatternRect = Rect.fromLTWH(
        bounds.left + (i * _accurateLength),
        bounds.top,
        _accurateLength,
        _accurateLength,
      );

      Rect bottomSidePatternRect = Rect.fromLTWH(
        bounds.left + (i * _accurateLength),
        bounds.bottom - _accurateLength,
        _accurateLength,
        _accurateLength,
      );

      innerPath.addRotatedRect(topSidePatternRect);
      outerPath.addRect(topSidePatternRect);

      innerPath.addRotatedRect(bottomSidePatternRect);
      outerPath.addRect(bottomSidePatternRect);
    }
  }
}

extension on Path {
  /*void addRotatedRect(Rect bounds) {
    moveTo(bounds.left, bounds.center.dy);
    lineTo(bounds.center.dx, bounds.top+5);
    lineTo(bounds.center.dx+5, bounds.top+5);
    lineTo(bounds.right, bounds.center.dy);
    lineTo(bounds.center.dx, bounds.bottom);
    close();
  }*/
  void addRotatedRect(Rect bounds) {
    moveTo(bounds.left, bounds.center.dy);
    lineTo(bounds.center.dx+5, bounds.top);
    lineTo(bounds.center.dx-5, bounds.top);
    lineTo(bounds.right, bounds.center.dy);
    lineTo(bounds.center.dx, bounds.bottom);
    close();
  }
}