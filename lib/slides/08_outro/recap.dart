import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/slides/00_intro/happy_sparkles_preview_slide.dart';
import 'package:fluttercon_2024/slides/03_eyes/moving_eyes_slide.dart';
import 'package:fluttercon_2024/slides/04_sparkles/moving_sparkles_slide.dart';
import 'package:fluttercon_2024/slides/04_sparkles/sparkles_slide.dart';
import 'package:fluttercon_2024/slides/05_speakers/moving_speakers_slide.dart';
import 'package:fluttercon_2024/utils/fitted_text.dart';
import 'package:fluttercon_2024/utils/happy_sparkles.dart';
import 'package:fluttercon_2024/utils/stretched_column.dart';
import 'package:fluttercon_2024/utils/vertical_carousel.dart';

const _speakerNotes = '''
1. First we saw how to draw simple shapes on the canvas.
2. Then we saw how to repaint the canvas when your widget rebuilds.
3. After that we saw how to not be bald too early by saving you for doing too much math.
4. We also saw how to repaint automatically your painter with an animation.
5. Then with drawAtlas, you learnt how to make a single call to the GPU and draw multiple images on the screen, at the same time.
6. I hope I demystified the saveLayer method for you, by showing you one use case where it can come to the rescue.
7. And finally we saw how to draw efficiently a lot of vertices on the screen.
''';

class RecapSlide extends FlutterDeckSlideWidget {
  const RecapSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/recap',
            title: 'Recap',
            steps: 7,
            speakerNotes: _speakerNotes,
            header: FlutterDeckHeaderConfiguration(showHeader: false),
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) => const _Left(),
      rightBuilder: (context) => const _Right(),
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
        return AnimatedVerticalCarousel(
          step: step - 1,
          children: const [
            StretchedColumn(
              widthFactor: widthFactor,
              children: [
                FittedText('Draw'),
                FittedText('Simple'),
                FittedText('Shapes'),
              ],
            ),
            StretchedColumn(
              widthFactor: widthFactor,
              children: [
                FittedText('Repaint'),
                FittedText('on Rebuild'),
              ],
            ),
            StretchedColumn(
              widthFactor: widthFactor,
              children: [
                FittedText('Canvas'),
                FittedText('Save'),
              ],
            ),
            StretchedColumn(
              widthFactor: widthFactor,
              children: [
                FittedText('Repaint'),
                FittedText('with an'),
                FittedText('animation'),
              ],
            ),
            StretchedColumn(
              widthFactor: widthFactor,
              children: [
                FittedText('Canvas'),
                FittedText('DrawAtlas'),
              ],
            ),
            StretchedColumn(
              widthFactor: widthFactor,
              children: [
                FittedText('Canvas'),
                FittedText('SaveLayer'),
              ],
            ),
            StretchedColumn(
              widthFactor: widthFactor,
              children: [
                FittedText('Canvas'),
                FittedText('DrawVertices'),
              ],
            ),
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
    return FlutterDeckSlideStepsBuilder(
      builder: (context, step) {
        return AnimatedVerticalCarousel(
          step: step - 1,
          fitHeight: true,
          children: [
            HappySparkles(
              image: null,
              particles: const [],
              mousePosition: Offset.zero,
              controller: null,
              drawMode: HappySparklesDrawMode.onlyFace +
                  HappySparklesDrawMode.onlyMouth,
            ),
            const MovingEyesPreview(),
            const SparklesPreview(),
            const MovingSparklesPreview(),
            const MovingSpeakersPreview(),
            HappySparkles(
              image: null,
              particles: const [],
              mousePosition: Offset.zero,
              controller: null,
              opacity: 0.5,
              drawMode: HappySparklesDrawMode.onlyFace +
                  HappySparklesDrawMode.onlyMouth +
                  HappySparklesDrawMode.onlyEyes,
            ),
            const HappySparklesPreview(
              drawMode: HappySparklesDrawMode.onlyParticles,
            ),
          ],
        );
      },
    );
  }
}
