import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:fluttercon_2024/utils/colors.dart';
import 'package:fluttercon_2024/utils/sparkle_extensions.dart';

abstract class HappySparklesDrawMode {
  const HappySparklesDrawMode._();

  static const all = SimpleHappySparklesMode(
    faceEnabled: true,
    mouthEnabled: true,
    eyesEnabled: true,
    speakersEnabled: true,
    sparklesEnabled: true,
    particlesEnabled: true,
    messageEnabled: false,
  );

  static const allWithMessage = SimpleHappySparklesMode(
    faceEnabled: true,
    mouthEnabled: true,
    eyesEnabled: true,
    speakersEnabled: true,
    sparklesEnabled: true,
    particlesEnabled: true,
    messageEnabled: true,
  );

  static const none = SimpleHappySparklesMode(
    faceEnabled: false,
    mouthEnabled: false,
    eyesEnabled: false,
    speakersEnabled: false,
    sparklesEnabled: false,
    particlesEnabled: false,
    messageEnabled: false,
  );

  static const onlyFace = SimpleHappySparklesMode(
    faceEnabled: true,
    mouthEnabled: false,
    eyesEnabled: false,
    speakersEnabled: false,
    sparklesEnabled: false,
    particlesEnabled: false,
    messageEnabled: false,
  );

  static const onlyMouth = SimpleHappySparklesMode(
    faceEnabled: false,
    mouthEnabled: true,
    eyesEnabled: false,
    speakersEnabled: false,
    sparklesEnabled: false,
    particlesEnabled: false,
    messageEnabled: false,
  );

  static const onlyEyes = SimpleHappySparklesMode(
    faceEnabled: false,
    mouthEnabled: false,
    eyesEnabled: true,
    speakersEnabled: false,
    sparklesEnabled: false,
    particlesEnabled: false,
    messageEnabled: false,
  );

  static const onlySpeakers = SimpleHappySparklesMode(
    faceEnabled: false,
    mouthEnabled: false,
    eyesEnabled: false,
    speakersEnabled: true,
    sparklesEnabled: false,
    particlesEnabled: false,
    messageEnabled: false,
  );

  static const onlySparkles = SimpleHappySparklesMode(
    faceEnabled: false,
    mouthEnabled: false,
    eyesEnabled: false,
    speakersEnabled: false,
    sparklesEnabled: true,
    particlesEnabled: false,
    messageEnabled: false,
  );

  static const onlyParticles = SimpleHappySparklesMode(
    faceEnabled: false,
    mouthEnabled: false,
    eyesEnabled: false,
    speakersEnabled: false,
    sparklesEnabled: false,
    particlesEnabled: true,
    messageEnabled: false,
  );

  HappySparklesDrawMode operator +(HappySparklesDrawMode other) {
    return _CombineHappySparklesMode(a: this, b: other);
  }

  bool get faceEnabled;
  bool get mouthEnabled;
  bool get eyesEnabled;
  bool get speakersEnabled;
  bool get sparklesEnabled;
  bool get particlesEnabled;
  bool get messageEnabled;
}

class SimpleHappySparklesMode extends HappySparklesDrawMode {
  const SimpleHappySparklesMode({
    required this.faceEnabled,
    required this.mouthEnabled,
    required this.eyesEnabled,
    required this.speakersEnabled,
    required this.sparklesEnabled,
    required this.particlesEnabled,
    required this.messageEnabled,
  }) : super._();

  @override
  final bool faceEnabled;
  @override
  final bool mouthEnabled;
  @override
  final bool eyesEnabled;
  @override
  final bool speakersEnabled;
  @override
  final bool sparklesEnabled;
  @override
  final bool particlesEnabled;
  @override
  final bool messageEnabled;
}

class _CombineHappySparklesMode extends HappySparklesDrawMode {
  const _CombineHappySparklesMode({
    required this.a,
    required this.b,
  }) : super._();

  final HappySparklesDrawMode a;
  final HappySparklesDrawMode b;

  @override
  bool get faceEnabled => a.faceEnabled || b.faceEnabled;

  @override
  bool get mouthEnabled => a.mouthEnabled || b.mouthEnabled;

  @override
  bool get eyesEnabled => a.eyesEnabled || b.eyesEnabled;

  @override
  bool get speakersEnabled => a.speakersEnabled || b.speakersEnabled;

  @override
  bool get sparklesEnabled => a.sparklesEnabled || b.sparklesEnabled;

  @override
  bool get particlesEnabled => a.particlesEnabled || b.particlesEnabled;

  @override
  bool get messageEnabled => a.messageEnabled || b.messageEnabled;
}

class HappySparkles extends StatelessWidget {
  const HappySparkles({
    super.key,
    required this.image,
    required this.particles,
    required this.mousePosition,
    required this.controller,
    required this.drawMode,
    this.opacity = 0.95,
    this.useSaveLayer = true,
    this.useDrawVertices = true,
  });

  final ui.Image? image;
  final List<Particle> particles;
  final Offset mousePosition;
  final Animation<double>? controller;
  final HappySparklesDrawMode drawMode;
  final double opacity;
  final bool useSaveLayer;
  final bool useDrawVertices;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomPaint(
        painter: _HappySparklesPainter(
          image: image,
          particles: particles,
          mousePosition: mousePosition,
          animation: controller,
          drawMode: drawMode,
          opacity: opacity,
          useSaveLayer: useSaveLayer,
          useDrawVertices: useDrawVertices,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _HappySparklesPainter extends CustomPainter {
  const _HappySparklesPainter({
    required this.image,
    required this.mousePosition,
    required this.animation,
    required this.particles,
    required this.drawMode,
    required this.opacity,
    required this.useSaveLayer,
    required this.useDrawVertices,
  }) : super(repaint: animation);

  final ui.Image? image;
  final Offset mousePosition;
  final Animation<double>? animation;
  final List<Particle> particles;
  final HappySparklesDrawMode drawMode;
  final double opacity;
  final bool useSaveLayer;
  final bool useDrawVertices;

  @override
  void paint(Canvas canvas, Size size) {
    final side = size.shortestSide;
    final rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: side / 2,
    );
    final faceRect = rect.deflate(side / 10);
    if (drawMode.speakersEnabled) {
      paintSpeakers(canvas, Offset.zero & size);
    }
    if (useSaveLayer) {
      canvas.saveLayer(
        faceRect,
        Paint()..color = const Color(0xFF000000).withOpacity(opacity),
      );
    }
    if (drawMode.faceEnabled) {
      paintFace(canvas, faceRect);
    }

    if (drawMode.mouthEnabled) {
      paintMouth(canvas, faceRect);
    }

    if (drawMode.eyesEnabled) {
      paintEyes(canvas, faceRect);
    }
    if (useSaveLayer) {
      canvas.restore();
    }

    if (drawMode.sparklesEnabled) {
      paintSparkles(canvas, rect, side / 10);
    }

    if (drawMode.particlesEnabled) {
      if (useDrawVertices) {
        paintParticles(canvas, rect);
      } else {
        paintParticlesWithDrawRect(canvas, rect);
      }
    }

    if (drawMode.messageEnabled) {
      paintMessage(canvas, Offset.zero & size);
    }
  }

  void paintSpeakers(Canvas canvas, Rect rect) {
    if (image case final spriteSheet?) {
      const speakerCount = 21;
      final paint = Paint()..color = Colors.transparent.withOpacity(0.8);
      final speakerConfig = computeSpeakerConfig(rect);

      final rects = <Rect>[];
      final transforms = <RSTransform>[];

      for (int i = 0; i < speakerCount; i++) {
        rects.add(Rect.fromLTWH(400.0 * i, 0, 400, 400));

        final offset = computeTranslation(i, speakerConfig);
        transforms.add(RSTransform.fromComponents(
          rotation: 0,
          scale: speakerConfig.scale,
          anchorX: 0,
          anchorY: 0,
          translateX: offset.dx,
          translateY: offset.dy,
        ));
      }

      canvas.drawAtlas(spriteSheet, transforms, rects, null, null, null, paint);
    }
  }

  _SpeakerConfig computeSpeakerConfig(Rect rect) {
    final padding = rect.height / 10;
    final speakerSize = padding * 2;
    final speakerStride = speakerSize + padding;
    const maxImagePerRow = 7;

    final totalWidth = maxImagePerRow * speakerStride;
    final mod = totalWidth - speakerStride;
    final delta = totalWidth * (animation?.value ?? 0);

    return _SpeakerConfig(
      maxImagePerRow: maxImagePerRow,
      delta: delta,
      padding: padding,
      speakerStride: speakerStride,
      totalWidth: totalWidth,
      mod: mod,
      scale: speakerSize / 400,
    );
  }

  Offset computeTranslation(int index, _SpeakerConfig config) {
    final y = index ~/ config.maxImagePerRow;
    final x = index % config.maxImagePerRow;
    final d = y == 1 ? -config.delta : config.delta;
    final paddingLine = y.isEven ? 0 : -config.padding * 3 / 2;

    final px = config.speakerStride * x + d + paddingLine;
    final py = config.speakerStride * y + config.padding;

    final tx = switch (px) {
      final a when a < -config.speakerStride => a + config.totalWidth,
      final a when a > config.mod => a - config.totalWidth,
      _ => px,
    };
    final ty = py;
    return Offset(tx, ty);
  }

  void paintSparkles(Canvas canvas, Rect rect, double maxSize) {
    final sparkleCenter = Offset(rect.shortestSide / 2 - maxSize / 2, 0);
    final sparkleSize = maxSize * 0.8;
    final sparklePaint = Paint()
      ..color = const Color(0xFFFFCD00)
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, sparkleSize / 5);
    const twoPi = math.pi * 2;
    const count = 10;

    canvas.save();
    canvas.translate(rect.center.dx, rect.center.dy);
    canvas.rotate(twoPi * (animation?.value ?? 0));
    for (int i = 0; i < count; i++) {
      canvas.drawSparkle(sparkleCenter, sparkleSize, sparklePaint);
      canvas.rotate(twoPi / count);
    }
    canvas.restore();
  }

  void paintSparklesHardWay(Canvas canvas, Rect rect, double maxSize) {
    final center = rect.center;
    final distance = rect.shortestSide / 2 - maxSize / 2;
    final sparkleSize = maxSize * 0.8;
    final sparklePaint = Paint()
      ..color = const Color(0xFFFFCD00)
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, sparkleSize / 5);
    const twoPi = math.pi * 2;
    const count = 10;

    for (int i = 0; i < count; i++) {
      final angle = twoPi * i / count;
      final dx = distance * math.cos(angle);
      final dy = distance * math.sin(angle);
      final newCenter = Offset(dx + center.dx, dy + center.dy);
      canvas.drawSparkle(newCenter, sparkleSize, sparklePaint);
    }
  }

  void paintFace(Canvas canvas, Rect rect) {
    final radius = rect.shortestSide / 2;
    final center = rect.center;
    final op = useSaveLayer ? 1.0 : opacity;

    final paint = Paint()
      ..shader = ui.Gradient.radial(
        center,
        radius,
        [
          const Color(0xFFFFCD00).withOpacity(op),
          const Color(0xFFFFAA00).withOpacity(op),
        ],
      );

    canvas.drawCircle(center, radius, paint);
  }

  void paintMouth(Canvas canvas, Rect rect) {
    final width = rect.shortestSide / 2;
    final height = width * 0.5;
    final center = rect.center + Offset(0, width * 0.5);
    final mouthRect = Rect.fromCenter(
      center: center,
      width: width,
      height: height,
    );
    final rrect = RRect.fromRectAndCorners(
      mouthRect,
      bottomLeft: Radius.circular(height),
      bottomRight: Radius.circular(height),
    );

    final op = useSaveLayer ? 1.0 : opacity;
    final paint = Paint()..color = const Color(0xFFB57700).withOpacity(op);

    canvas.drawRRect(rrect, paint);
  }

  void paintEyes(Canvas canvas, Rect rect) {
    final shortestSide = rect.shortestSide;
    final x = shortestSide / 5;
    final y = rect.topLeft.dy + shortestSide / 3;
    final cx = rect.center.dx;
    paintEye(canvas, rect, Offset(cx - x, y));
    paintEye(canvas, rect, Offset(cx + x, y));
  }

  void paintEye(Canvas canvas, Rect rect, Offset center) {
    final op = useSaveLayer ? 1.0 : opacity;

    final eyeCenter = Offset(center.dx, center.dy);
    final eyeRadius = rect.shortestSide / 8;
    final eyePaint = Paint()..color = const Color(0xFFFFFFFF).withOpacity(op);
    canvas.drawCircle(eyeCenter, eyeRadius, eyePaint);

    final rotation = math.atan2(
      mousePosition.dy - eyeCenter.dy,
      mousePosition.dx - eyeCenter.dx,
    );

    final eyeBallCenter = eyeCenter +
        Offset(math.cos(rotation), math.sin(rotation)) * eyeRadius / 3;
    final eyeBallRadius = eyeRadius / 2;
    final eyeBallPaint = Paint()
      ..color = const Color(0xFF000000).withOpacity(op);
    canvas.drawCircle(eyeBallCenter, eyeBallRadius, eyeBallPaint);
  }

  void paintParticlesWithDrawRect(Canvas canvas, Rect rect) {
    final paint = Paint()..blendMode = BlendMode.colorDodge;

    const solidColor = Color(0xFFFFAA00);
    for (int i = particles.length - 1; i >= 0; i--) {
      final particle = particles[i];
      final createdAt = particle.createdAt;

      final ms = DateTime.now().difference(createdAt).inMilliseconds;
      final opacity = 1 - (ms / 1000).clamp(0.0, 1.0);
      if (opacity == 0) {
        particles.removeAt(i);
      } else {
        canvas.drawRect(
          Rect.fromCircle(
            center: particle.position,
            radius: particle.size / 2,
          ),
          paint..color = solidColor.withOpacity(opacity),
        );
      }
    }
  }

  void paintParticles(Canvas canvas, Rect rect) {
    final colors = <Color>[];
    final positions = <Offset>[];
    final indices = <int>[];

    for (int i = particles.length - 1; i >= 0; i--) {
      final particle = particles[i];
      if (!particle.insertInto(positions, indices, colors)) {
        particles.removeAt(i);
      }
    }

    final vertices = ui.Vertices(
      VertexMode.triangles,
      positions,
      colors: colors,
      indices: indices,
    );

    canvas.drawVertices(
      vertices,
      BlendMode.dst,
      Paint()..blendMode = BlendMode.colorDodge,
    );
  }

  void paintMessage(Canvas canvas, Rect rect) {
    final bubbleRect = Rect.fromCenter(
      center: rect.center,
      width: 350,
      height: 132,
    ).shift(Offset(rect.width / 4, 40));
    const radius = Radius.circular(32);
    final bubble = RRect.fromRectAndCorners(
      bubbleRect,
      topLeft: radius,
      topRight: radius,
      bottomRight: radius,
    );

    final bubblePath = Path();
    bubblePath.addRRect(bubble);
    bubblePath.addPolygon(
      [
        bubbleRect.bottomLeft,
        bubbleRect.bottomLeft + Offset(0, rect.height / 16),
        bubbleRect.bottomLeft + Offset(rect.height / 16, 0),
      ],
      true,
    );

    final paint = Paint()..color = DeckColors.platinium;

    canvas.saveLayer(
        rect, Paint()..color = Colors.transparent.withOpacity(0.95));
    canvas.drawPath(bubblePath, paint);

    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'Danke!',
        style: TextStyle(
          color: DeckColors.eerieBlack,
          fontSize: 100,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: bubbleRect.width - 32);

    textPainter.paint(canvas, bubbleRect.topLeft + const Offset(16, 16));
    canvas.restore();
  }

  @override
  bool shouldRepaint(_HappySparklesPainter oldDelegate) {
    return oldDelegate.mousePosition != mousePosition ||
        oldDelegate.opacity != opacity ||
        oldDelegate.useSaveLayer != useSaveLayer;
  }
}

class Particle {
  const Particle({
    required this.position,
    required this.createdAt,
    required this.size,
  });

  factory Particle.fromPosition(Offset position, math.Random random) {
    final size = random.nextInt(4) + 2;
    final deltaX = random.nextDouble() * 20;
    final deltaY = random.nextDouble() * 20;
    return Particle(
      position: position + Offset(deltaX, deltaY),
      createdAt: DateTime.now(),
      size: size.toDouble(),
    );
  }

  final Offset position;
  final DateTime createdAt;
  final double size;

  bool insertInto(
    List<Offset> positions,
    List<int> indices,
    List<Color> colors,
  ) {
    const solidColor = Color(0xFFFFAA00);

    final ms = DateTime.now().difference(createdAt).inMilliseconds;
    final opacity = 1 - (ms / 1000).clamp(0.0, 1.0);

    if (opacity == 0) {
      return false;
    }

    final rawColor = solidColor.withOpacity(opacity);
    for (int j = 0; j < 4; j++) {
      colors.add(rawColor);
    }

    final count = positions.length;
    indices.addAll(
      [
        count,
        count + 1,
        count + 2,
        count + 1,
        count + 2,
        count + 3,
      ],
    );
    positions.addAll([
      position,
      position + Offset(size, 0),
      position + Offset(0, size),
      position + Offset(size, size),
    ]);

    return true;
  }
}

class _SpeakerConfig {
  const _SpeakerConfig({
    required this.maxImagePerRow,
    required this.delta,
    required this.padding,
    required this.speakerStride,
    required this.totalWidth,
    required this.mod,
    required this.scale,
  });

  final int maxImagePerRow;
  final double delta;
  final double padding;
  final double speakerStride;
  final double totalWidth;
  final double mod;
  final double scale;
}
