import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/colors.dart';
import 'package:fluttercon_2024/utils/fitted_text.dart';
import 'package:fluttercon_2024/utils/happy_sparkles.dart';
import 'package:fluttercon_2024/utils/stretched_column.dart';
import 'package:fluttercon_2024/utils/vertical_carousel.dart';
import 'package:performance/performance.dart';

const _speakerNotes = '''
The last tip I want to share with you, is how we can create particles effects efficiently. Or if you want to draw a lot of shapes on the screen and being performant at the same time.

Here, when I move the mouse, I want to create some particles, which are just rectangles of different sizes and opacities.
For the moment we create these rectangles with the drawRect method. As you can see it's not very smooth.

To improve this we can use drawVertices instead. This is a very powerful method that allows you to batch, in a single operation, the drawing of a lot of polygons on the screen.
So as you can see it can make the difference.
Filip Hracek made an entire video about it, I highly recommend you to watch it.if you want to go deeper.

Let's look a little deeper at the code.
When we call drawVertices, we need to provide it as intance of Vertices.
Vertices has a mode to tell how to draw the lines between the points we provide. Here I set it to triangles.
In this mode it will draw each sequence of three points as the vertices of a triangle.
By default in this mode, if we want to draw a rectangle we will need to provide 6 points. 3 for each triangles represeting the rectangle.
But in fact we only need 4 point to represent a rectangle.
In this case it can be better, memory wise, to provide only 4 points in positions. And to use the indices parameter to tell the method how to draw the triangles.
''';

class ParticlesSlide extends FlutterDeckSlideWidget {
  const ParticlesSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/particles',
            title: 'Particles',
            speakerNotes: _speakerNotes,
            steps: 7,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) {
        return const _Left();
      },
      rightBuilder: (context) {
        return const _Right();
      },
    );
  }
}

class _Left extends StatelessWidget {
  const _Left();

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlideStepsBuilder(
      builder: (context, step) {
        return AnimatedVerticalCarousel(
          step: step - 1,
          fitHeight: true,
          children: [
            Image.asset('assets/paint_particles_with_draw_rect.png'),
            const StretchedColumn(
              widthFactor: 0.9,
              children: [
                FittedText('Canvas.'),
                FittedText(
                  'drawVertices',
                  color: BrandColors.positive,
                ),
              ],
            ),
            Image.asset('assets/paint_particles.png'),
          ],
        );
      },
    );
  }
}

class _Right extends StatelessWidget {
  const _Right();

  @override
  Widget build(BuildContext context) {
    final deckTheme = FlutterDeckTheme.of(context);
    final textStyle = deckTheme.textTheme.title.copyWith(
      fontSize: 36,
      fontWeight: FontWeight.normal,
      height: 1.6,
    );

    return FlutterDeckSlideStepsBuilder(
      builder: (context, step) {
        final effectiveStep = switch (step) {
          >= 4 => step - 3,
          _ => 0,
        };
        return AnimatedVerticalCarousel(
          step: effectiveStep,
          fitHeight: true,
          children: [
            const _Preview(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: FractionallySizedBox(
                      heightFactor: 0.5,
                      widthFactor: 0.5,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: CustomPaint(
                          painter: _ExplanationPainter(step: step - 3),
                          child: const SizedBox.expand(),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: step > 5 ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child:
                      Text('positions: [A, B, C, D, E, F] ', style: textStyle),
                ),
                AnimatedOpacity(
                  opacity: step > 6 ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    'or\npositions: [A, B, C, D]\nindices: [0, 1, 2, 3, 0, 2] ',
                    style: textStyle,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _Preview extends StatefulWidget {
  const _Preview();

  @override
  State<_Preview> createState() => _PreviewState();
}

class _PreviewState extends State<_Preview>
    with SingleTickerProviderStateMixin {
  ui.Image? image;
  Offset mousePosition = Offset.zero;
  final particles = <Particle>[];
  final random = math.Random();
  late final controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  );

  @override
  void initState() {
    super.initState();
    controller.repeat(reverse: false);
    loadImage();
  }

  void loadImage() async {
    final data = await rootBundle.load('assets/speakers.png');
    final bytes = data.buffer.asUint8List();
    image = await decodeImageFromList(bytes);
    setState(() {});
  }

  void addParticles(Offset position) {
    final count = random.nextInt(50) + 4;
    for (int i = 0; i < count; i++) {
      particles.add(Particle.fromPosition(position, random));
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = FlutterDeck.of(context).globalConfiguration.slideSize.width ?? 0;
    return FlutterDeckSlideStepsBuilder(builder: (context, step) {
      final useDrawVertices = step >= 2;
      final method = useDrawVertices ? 'drawVertices' : 'drawRect';
      return CustomPerformanceOverlay(
        scale: w / 1920.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Using canvas.$method',
              style: FlutterDeckTheme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.left,
            ),
            Expanded(
              child: ClipRect(
                child: MouseRegion(
                  onHover: (event) {
                    setState(() {
                      addParticles(event.localPosition);
                    });
                  },
                  child: HappySparkles(
                    image: image,
                    particles: particles,
                    mousePosition: mousePosition,
                    controller: controller,
                    drawMode: HappySparklesDrawMode.all,
                    useDrawVertices: useDrawVertices,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _ExplanationPainter extends CustomPainter {
  const _ExplanationPainter({
    required this.step,
  });

  final int step;

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    const triangle01Color = BrandColors.onSurface;
    final pointA = size.relativeOffset(0, 0);
    final pointB = size.relativeOffset(1, 0);
    final pointC = size.relativeOffset(1, 1);
    final pointD = size.relativeOffset(0, 1);

    final triangle01Vertices = ui.Vertices(
      VertexMode.triangles,
      [pointA, pointB, pointC],
    );
    canvas.drawVertices(
      triangle01Vertices,
      BlendMode.src,
      Paint()..color = triangle01Color,
    );

    canvas.drawVertex(
      offset: pointA,
      label: 'A',
      position: _VertexPosition.top,
      color: triangle01Color,
    );
    canvas.drawVertex(
      offset: pointB,
      label: 'B',
      position: _VertexPosition.top,
      color: triangle01Color,
    );

    canvas.drawVertex(
      offset: pointC,
      label: 'C',
      position: _VertexPosition.bottom,
      color: triangle01Color,
    );

    if (step < 2) {
      return;
    }

    const triangle02Color = BrandColors.positive;
    final triangle02Vertices = ui.Vertices(
      VertexMode.triangles,
      [pointD, pointA, pointC],
    );
    canvas.drawVertices(
      triangle02Vertices,
      BlendMode.src,
      Paint()..color = triangle02Color,
    );

    canvas.drawVertex(
      offset: pointD,
      label: 'D',
      position: _VertexPosition.left,
      color: triangle02Color,
    );

    canvas.drawVertex(
      offset: pointA,
      label: 'E',
      position: _VertexPosition.left,
      color: triangle02Color,
    );

    canvas.drawVertex(
      offset: pointC,
      label: 'F',
      position: _VertexPosition.right,
      color: triangle02Color,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

enum _VertexPosition {
  top,
  left,
  right,
  bottom,
}

extension on Size {
  Offset relativeOffset(double x, double y) {
    return Offset(width * x, height * y);
  }
}

extension on Canvas {
  void drawVertex({
    required Offset offset,
    required String label,
    required _VertexPosition position,
    required Color color,
  }) {
    const radius = 8.0;
    const margin = 16.0;

    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: color,
          fontFamily: 'BigFont',
          fontSize: 50,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final textOffset = switch (position) {
      _VertexPosition.top => Offset(
          -textPainter.width / 2,
          -textPainter.height - radius - margin,
        ),
      _VertexPosition.left => Offset(
          -textPainter.width - radius - margin,
          -textPainter.height / 2,
        ),
      _VertexPosition.right => Offset(
          radius + margin,
          -textPainter.height / 2,
        ),
      _VertexPosition.bottom => Offset(
          -textPainter.width / 2,
          radius + margin,
        ),
    };

    drawCircle(
      offset,
      radius + 2,
      Paint()..color = BrandColors.dark,
    );

    drawCircle(
      offset,
      radius,
      Paint()..color = color,
    );

    textPainter.paint(this, offset + textOffset);
  }
}
