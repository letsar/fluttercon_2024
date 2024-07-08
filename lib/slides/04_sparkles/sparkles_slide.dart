import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/colors.dart';
import 'package:fluttercon_2024/utils/fitted_text.dart';
import 'package:fluttercon_2024/utils/happy_sparkles.dart';
import 'package:fluttercon_2024/utils/stretched_column.dart';
import 'package:fluttercon_2024/utils/vertical_carousel.dart';

const _speakerNotes = '''
The sparkles are pretty interesting because as you see, they are positioned in a circle and they are rotated
so that  they all point to the center of the circle.
There are multiple ways to do it:

The hard one with a looooooot of math:
Cosinus, sinus, matrix multiplication, and so on.
Too much for me ! 

Or you can do it the clever (lazy) way using the canvas.save method.

Let's look at the Flutter documentation first.
''';

class SparklesSlide extends FlutterDeckSlideWidget {
  const SparklesSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/sparkles',
            title: 'Sparkles',
            steps: 6,
            speakerNotes: _speakerNotes,
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
        return const SparklesPreview();
      },
    );
  }
}

class _Left extends StatelessWidget {
  const _Left();

  @override
  Widget build(BuildContext context) {
    const widthFactor = 0.9;
    return FlutterDeckSlideStepsBuilder(
      builder: (context, step) {
        final rootStep = switch (step) {
          > 4 => step - 3,
          > 1 => 1,
          _ => 0,
        };
        return AnimatedVerticalCarousel(
          step: rootStep,
          fitHeight: true,
          children: [
            const SizedBox.expand(),
            Center(
              child: AnimatedVerticalCarousel(
                step: step - 2,
                fitHeight: false,
                children: const [
                  StretchedColumn(
                    widthFactor: widthFactor,
                    children: [
                      FittedText('Cosinus'),
                    ],
                  ),
                  StretchedColumn(
                    widthFactor: widthFactor,
                    children: [
                      FittedText('Sinus'),
                    ],
                  ),
                  StretchedColumn(
                    widthFactor: widthFactor,
                    children: [
                      FittedText('Matrix'),
                      FittedText('Multiplication'),
                    ],
                  ),
                ],
              ),
            ),
            const _MathGif(),
            const StretchedColumn(
              widthFactor: widthFactor,
              children: [
                FittedText('Canvas.'),
                FittedText(
                  'save',
                  color: BrandColors.positive,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _MathGif extends StatelessWidget {
  const _MathGif();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/math.webp',
      fit: BoxFit.cover,
    );
  }
}

class SparklesPreview extends StatelessWidget {
  const SparklesPreview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: HappySparkles(
        image: null,
        particles: [],
        mousePosition: Offset.zero,
        controller: null,
        drawMode: HappySparklesDrawMode.onlySparkles,
      ),
    );
  }
}
