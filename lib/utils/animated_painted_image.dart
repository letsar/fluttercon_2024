import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class AnimatedPaintedImage extends StatefulWidget {
  const AnimatedPaintedImage({
    super.key,
    required this.assetName,
  });

  final String assetName;

  @override
  State<AnimatedPaintedImage> createState() => _AnimatedPaintedImageState();
}

class _AnimatedPaintedImageState extends State<AnimatedPaintedImage> {
  final Random random = Random();
  ui.Image? image;
  ByteData? byteData;

  @override
  void initState() {
    super.initState();
    loadPixels();
  }

  @override
  void dispose() {
    image?.dispose();
    super.dispose();
  }

  Future<void> loadPixels() async {
    image?.dispose();
    final provider = ExactAssetImage(widget.assetName);
    final imageStream = provider.resolve(ImageConfiguration.empty);
    final completer = Completer<ui.Image>();
    late ImageStreamListener imageStreamListener;
    imageStreamListener = ImageStreamListener((frame, _) {
      completer.complete(frame.image);
      imageStream.removeListener(imageStreamListener);
    });
    imageStream.addListener(imageStreamListener);
    image = await completer.future;
    byteData = await image?.toByteData(format: ui.ImageByteFormat.rawRgba);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final localImage = image;
    return localImage == null
        ? const SizedBox.expand()
        : SizedBox.expand(
            child: _PortaitPaint(
              imgWidth: localImage.width,
              imgHeight: localImage.height,
              byteData: byteData!,
              random: random,
            ),
          );
  }
}

class _PortaitPaint extends StatefulWidget {
  const _PortaitPaint({
    required this.imgWidth,
    required this.imgHeight,
    required this.byteData,
    required this.random,
  });

  final int imgWidth;
  final int imgHeight;
  final ByteData byteData;
  final Random random;

  @override
  State<_PortaitPaint> createState() => _PortaitPaintState();
}

class _PortaitPaintState extends State<_PortaitPaint>
    with SingleTickerProviderStateMixin {
  final _paintMoves = <_PaintMove>[];
  late final controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  );
  late final animation = Tween(begin: 0.0, end: 300.0)
      .chain(CurveTween(curve: Curves.fastLinearToSlowEaseIn.flipped))
      .animate(controller);

  @override
  void initState() {
    super.initState();
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: _PortraitPainter(
          widget.imgWidth,
          widget.imgHeight,
          widget.byteData,
          widget.random,
          _paintMoves,
          animation,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _PortraitPainter extends CustomPainter {
  _PortraitPainter(
    this.imgWidth,
    this.imgHeight,
    ByteData byteData,
    this.random,
    this.paintMoves,
    this.animation,
  )   : pixels = _Pixels(
          byteData: byteData,
          width: imgWidth,
          height: imgHeight,
        ),
        super(repaint: animation);

  final int imgWidth;
  final int imgHeight;
  final Random random;
  final Animation<double> animation;
  final List<_PaintMove> paintMoves;
  final _Pixels pixels;

  Offset currentTranslation = Offset.zero;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final tdx = (width - imgWidth) / 2;
    final tdy = (height - imgHeight) / 2;

    void curve(
      double x1,
      double y1,
      double x2,
      double y2,
      double x3,
      double y3,
      double x4,
      double y4,
      double thickness,
      Color color,
    ) {
      final vertices = [
        Offset(x1, y1),
        Offset(x2, y2),
        Offset(x3, y3),
        Offset(x4, y4),
      ];
      final path = Path();
      path.moveTo(x2, y2);
      for (int i = 1; i + 2 < vertices.length; i++) {
        final v = vertices[i];
        final b = List<Offset>.filled(4, Offset.zero);
        b[0] = v;
        b[1] = v + (vertices[i + 1] - vertices[i - 1]) / 6;
        b[2] = vertices[i + 1] + (v - vertices[i + 2]) / 6;
        b[3] = vertices[i + 1];
        path.cubicTo(b[1].dx, b[1].dy, b[2].dx, b[2].dy, b[3].dx, b[3].dy);
      }
      paintMoves.add(_PaintMove(
        path: path,
        color: color,
        translation: currentTranslation,
        thickness: thickness,
      ));
    }

    void paintStroke(double length, Color color, int thickness) {
      final stepLength = length / 4;

      // Determines if the stroke is curved. A straight line is 0.
      double tangent1 = 0;
      double tangent2 = 0;

      final odds = random.nextDouble();

      if (odds < 0.7) {
        tangent1 = random.d(-length, length);
        tangent2 = random.d(-length, length);
      }

      curve(
        tangent1,
        -stepLength * 2,
        0,
        -stepLength,
        0,
        stepLength,
        tangent2,
        stepLength * 2,
        thickness.toDouble(),
        color,
      );
    }

    for (var y = 0; y < imgHeight; y++) {
      for (var x = 0; x < imgWidth; x++) {
        final odds = random.d(0, 2000).toInt();

        if (odds < 1) {
          final color = pixels.getColorAt(x, y, maxAlpha: 128);
          final tx = x + tdx;
          final ty = y + tdy;
          currentTranslation = Offset(tx, ty);

          final counter = animation.value;
          if (counter < 20) {
            paintStroke(random.d(150, 250), color, random.d(20, 40).toInt());
          } else if (counter < 50) {
            paintStroke(random.d(75, 125), color, random.d(8, 12).toInt());
          } else if (counter < 300) {
            paintStroke(random.d(30, 60), color, random.d(1, 4).toInt());
          } else if (counter < 500) {
            paintStroke(random.d(10, 20), color, random.d(5, 15).toInt());
          } else {
            paintStroke(random.d(5, 10), color, random.d(1, 7).toInt());
          }
        }
      }
    }

    for (final move in paintMoves) {
      final paint = Paint()
        ..color = move.color
        ..strokeWidth = move.thickness
        ..style = PaintingStyle.stroke;

      canvas.translate(move.translation.dx, move.translation.dy);
      canvas.drawPath(move.path, paint);
      canvas.translate(-move.translation.dx, -move.translation.dy);
    }
  }

  @override
  bool shouldRepaint(_PortraitPainter oldDelegate) {
    return false;
  }
}

class _Pixels {
  const _Pixels({
    required this.byteData,
    required this.width,
    required this.height,
  });

  final ByteData byteData;
  final int width;
  final int height;

  Color getColorAt(int x, int y, {int maxAlpha = 255}) {
    final offset = 4 * (x + y * width);
    final rgba = byteData.getUint32(offset);
    final a = min(rgba & 0xFF, maxAlpha);
    final rgb = rgba >> 8;
    final argb = (a << 24) + rgb;
    return Color(argb);
  }
}

extension on Random {
  double d(double min, double max) {
    return nextDouble() * (max - min) + min;
  }
}

class _PaintMove {
  const _PaintMove({
    required this.path,
    required this.color,
    required this.translation,
    required this.thickness,
  });

  final Path path;
  final Color color;
  final Offset translation;
  final double thickness;
}
