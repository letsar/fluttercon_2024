import 'dart:math' as math;
import 'dart:ui';

extension SparkleExtensions on Canvas {
  void drawSparkle(Offset center, double size, Paint paint) {
    const ratio = 0.33;
    const vertices = 4;
    const r = 2 * math.pi / vertices;
    const hr = r / 2;

    final offsets = <Offset>[];
    for (int i = 0; i < vertices; i++) {
      final angle = i * r;
      offsets.add(
        Offset(
          math.cos(angle),
          math.sin(angle),
        ),
      );
      offsets.add(
        Offset(
          ratio * math.cos(angle + hr),
          ratio * math.sin(angle + hr),
        ),
      );
    }

    final rect = Rect.fromCircle(
      center: center,
      radius: size / 2,
    );
    final points = offsets.withinRect(rect);
    final path = Path()..addPolygon(points, true);
    drawPath(path, paint);
  }
}

extension on List<Offset> {
  List<Offset> withinRect(Rect rect) {
    final w = rect.width / 2;
    final h = rect.height / 2;
    final x = rect.left;
    final y = rect.top;
    return [
      for (final offset in this)
        Offset(
          offset.dx * w + x + w,
          offset.dy * h + y + h,
        )
    ];
  }
}
