import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/colors.dart';
import 'package:fluttercon_2024/utils/fitted_text.dart';
import 'package:fluttercon_2024/utils/happy_sparkles.dart';
import 'package:fluttercon_2024/utils/stretched_column.dart';
import 'package:fluttercon_2024/utils/vertical_carousel.dart';

const _speakerNotes = '''
Because all the shapes are overlapping, we cannot set the opacity to the colors of the differents parts of the face. 
The colors are mixed and the result is not what we want. Look, the white in the eyes is becoming more and more yellow.

But there is a simple solution to overcome this problem: the saveLayer method!
If we activate it we can see that the white in the eyes don't become yellow no more!
''';

class HappySparklesOpacitySlide extends FlutterDeckSlideWidget {
  const HappySparklesOpacitySlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/happy-sparkles-opacity',
            title: 'Happy Sparles Opacity',
            steps: 3,
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
        return const _Preview();
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
          children: const [
            SizedBox.expand(),
            StretchedColumn(
              widthFactor: 0.9,
              children: [
                FittedText('Canvas.'),
                FittedText(
                  'saveLayer',
                  color: BrandColors.positive,
                ),
              ],
            ),
            _Code(),
          ],
        );
      },
    );
  }
}

class _Code extends StatelessWidget {
  const _Code();

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/paint_happy_sparles_opacity.png');
  }
}

class _Preview extends StatefulWidget {
  const _Preview();

  @override
  State<_Preview> createState() => _PreviewState();
}

class _PreviewState extends State<_Preview> {
  double opacity = 0.95;
  bool usePaintOpacity = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Text(
                  'Opacity:',
                  style: FlutterDeckTheme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  width: 300,
                  child: Slider(
                    min: 0.0,
                    max: 1.0,
                    onChanged: (value) {
                      setState(() {
                        opacity = value;
                      });
                    },
                    value: opacity,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Use paint opacity:',
                  style: FlutterDeckTheme.of(context).textTheme.bodyLarge,
                ),
                Checkbox(
                  onChanged: (value) {
                    setState(() {
                      usePaintOpacity = value ?? true;
                    });
                  },
                  value: usePaintOpacity,
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: HappySparkles(
              image: null,
              particles: const [],
              mousePosition: Offset.zero,
              controller: null,
              opacity: opacity,
              useSaveLayer: !usePaintOpacity,
              drawMode: const SimpleHappySparklesMode(
                faceEnabled: true,
                eyesEnabled: true,
                mouthEnabled: true,
                sparklesEnabled: false,
                speakersEnabled: false,
                particlesEnabled: false,
                messageEnabled: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
