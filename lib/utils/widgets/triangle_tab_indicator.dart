import 'package:flutter/material.dart';

class TriangleTabIndicator extends Decoration {
  final BoxPainter _painter;

  TriangleTabIndicator({required Color color})
      : _painter = _TrianglePainter(color);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

class _TrianglePainter extends BoxPainter {
  final Paint _paint;

  _TrianglePainter(Color color)
      : _paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Rect rect = offset & cfg.size!;
    final double triangleWidth = rect.width / 2;
    const double indicatorHeight = 8;

    final Path path = Path()
      ..moveTo(rect.left + triangleWidth, rect.bottom - indicatorHeight)
      ..lineTo(rect.left + 1 * triangleWidth, rect.bottom - indicatorHeight)
      ..lineTo(rect.left + 1.75 * triangleWidth, rect.bottom)
      ..lineTo(rect.left + 0.25 * triangleWidth, rect.bottom)
      ..close();

    canvas.drawPath(path, _paint);
  }
}
