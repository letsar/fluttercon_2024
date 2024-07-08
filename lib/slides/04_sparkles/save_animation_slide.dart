import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/colors.dart';
import 'package:fluttercon_2024/utils/sparkle_extensions.dart';

const _speakerNotes = '''
Now I will show you an animation representing what happens behind the scene when we call the save method on the canvas for creating our sparkles.

First we translate the canvas, so that the center around which the sparkles rotate, is at (0,0).
Then we draw a sparkle at a defined offset from the center.
We rotate the canvas around its origin by the specified angle.
Then we draw another sparkle at the same offset from the center.
And we repeat this process for the number of sparkles we want to draw.
Finally we restore the canvas to its original state.
''';

class SaveAnimationSlide extends FlutterDeckSlideWidget {
  const SaveAnimationSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/save-animation-slide',
            title: 'Canvas.save animation',
            steps: 2,
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: LayoutBuilder(builder: (context, constraints) {
            return SizedBox.square(
              dimension: constraints.biggest.shortestSide / 2.5,
              child: Stack(
                children: [
                  FlutterDeckSlideStepsBuilder(
                    builder: (context, step) {
                      return CanvasSaveAnimation(
                        animate: step > 1,
                      );
                    },
                  ),
                  const _Axis(),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}

class _Axis extends StatelessWidget {
  const _Axis();

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(
      painter: _AxisPainter(),
      child: SizedBox.expand(),
    );
  }
}

class _AxisPainter extends CustomPainter {
  const _AxisPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const arrowSize = 10.0;

    final paint = Paint()
      ..color = DeckColors.platinium
      ..strokeWidth = 2.0;

    final ex = size.width - arrowSize;
    final ey = size.height - arrowSize;

    canvas.drawLine(Offset.zero, Offset(ex, 0), paint);
    canvas.drawLine(Offset.zero, Offset(0, ey), paint);
    canvas.drawPath(
        Path()
          ..addPolygon(
            [
              Offset(ex, -arrowSize / 2),
              Offset(ex, arrowSize / 2),
              Offset(size.width, 0),
            ],
            true,
          ),
        paint);

    canvas.drawPath(
        Path()
          ..addPolygon(
            [
              Offset(-arrowSize / 2, ey),
              Offset(arrowSize / 2, ey),
              Offset(0, size.height),
            ],
            true,
          ),
        paint);

    const textStyle = TextStyle(color: BrandColors.onSurface, fontSize: 40);
    final xText = TextPainter(
      text: const TextSpan(text: 'x', style: textStyle),
      textDirection: TextDirection.ltr,
    );
    xText.layout();
    xText.paint(canvas, Offset((ex - xText.width) / 2, -xText.height - 2));

    final yText = TextPainter(
      text: const TextSpan(text: 'y', style: textStyle),
      textDirection: TextDirection.ltr,
    );
    yText.layout();
    yText.paint(canvas, Offset(-yText.width - 4, (ey - yText.height) / 2));

    final oText = TextPainter(
      text: const TextSpan(text: '(0;0)', style: textStyle),
      textDirection: TextDirection.ltr,
    );
    oText.layout();
    oText.paint(canvas, Offset(-oText.width / 2, -oText.height - 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CanvasSaveAnimation extends StatefulWidget {
  const CanvasSaveAnimation({
    super.key,
    this.animate = true,
  });

  final bool animate;

  @override
  State<CanvasSaveAnimation> createState() => _CanvasSaveAnimationState();
}

class _CanvasSaveAnimationState extends State<CanvasSaveAnimation>
    with SingleTickerProviderStateMixin {
  static const _transitionDurationMs = 1500.0;
  late final controller = AnimationController(
    duration: Duration(milliseconds: _transitionDurationMs.toInt()) * 22,
    vsync: this,
  );

  late final position = TweenSequence(
    [
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-0.5, -0.5),
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: _transitionDurationMs,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(-0.5, -0.5),
          end: const Offset(-0.5, -0.5),
        ),
        weight: _transitionDurationMs * 20,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(-0.5, -0.5),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: _transitionDurationMs,
      ),
    ],
  ).animate(controller);

  late final turns = TweenSequence(
    [
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.0,
          end: 0.0,
        ),
        weight: _transitionDurationMs,
      ),
      for (int i = 0; i < _circleCount; i++) ...[
        TweenSequenceItem(
          tween: Tween<double>(
            begin: i / _circleCount,
            end: i / _circleCount,
          ),
          weight: _transitionDurationMs,
        ),
        TweenSequenceItem(
          tween: Tween<double>(
            begin: i / _circleCount,
            end: (i + 1) / _circleCount,
          ).chain(CurveTween(curve: Curves.easeIn)),
          weight: _transitionDurationMs,
        ),
      ],
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.0,
          end: 0.0,
        ),
        weight: _transitionDurationMs,
      ),
    ],
  ).animate(controller);

  late final progress = TweenSequence(
    [
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.0,
          end: 0.0,
        ),
        weight: _transitionDurationMs,
      ),
      for (double i = 0; i < _circleCount; i++) ...[
        TweenSequenceItem(
          tween: Tween<double>(
            begin: i,
            end: i + 1,
          ).chain(CurveTween(curve: Curves.easeIn)),
          weight: _transitionDurationMs,
        ),
        TweenSequenceItem(
          tween: Tween<double>(
            begin: i + 1,
            end: i + 1,
          ),
          weight: _transitionDurationMs,
        ),
      ],
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 10,
          end: 10,
        ),
        weight: _transitionDurationMs,
      ),
    ],
  ).animate(controller);

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant CanvasSaveAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        controller.forward();
      } else {
        controller.animateBack(0, duration: const Duration(milliseconds: 300));
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: position,
      child: RotationTransition(
        turns: turns,
        child: ColoredBox(
          color: DeckColors.eerieBlack,
          child: _Circles(
            color: const Color(0xFFFFCD00),
            progress: progress,
          ),
        ),
      ),
    );
  }
}

class _Circles extends StatelessWidget {
  const _Circles({
    required this.color,
    required this.progress,
  });

  final Color color;
  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CirclesPainter(
        color: color,
        progress: progress,
      ),
      child: const SizedBox.expand(),
    );
  }
}

const _twoPI = math.pi * 2.0;
const _circleCount = 10;

class _CirclesPainter extends CustomPainter {
  const _CirclesPainter({
    required this.color,
    required this.progress,
  }) : super(repaint: progress);

  final Color color;
  final Animation<double> progress;

  @override
  void paint(Canvas canvas, Size size) {
    final circleRadius = size.shortestSide / 6;
    final paint = Paint()..color = color;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);

    for (var i = 0; i < _circleCount; i++) {
      final opacity = (progress.value - i).clamp(0.0, 1.0);
      canvas.drawSparkle(
        Offset(circleRadius * 2, 0),
        circleRadius / 2,
        paint..color = color.withOpacity(opacity),
      );
      canvas.rotate(-_twoPI / _circleCount);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_CirclesPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
