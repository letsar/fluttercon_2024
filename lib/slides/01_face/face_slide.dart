import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/fitted_text.dart';
import 'package:fluttercon_2024/utils/happy_sparkles.dart';
import 'package:fluttercon_2024/utils/image_part.dart';
import 'package:fluttercon_2024/utils/stretched_column.dart';
import 'package:fluttercon_2024/utils/vertical_carousel.dart';

const _speakerNotes = '''
The face of Happy Sparkle is pretty easy, we draw a circle and to have this gradient effect, we apply it as a shader. Your can also use an ImageShader or a FragmentShader.
If you want to know more about fragment shaders, =>Renan and =>Raouf made great talks about them.
''';

class FaceSlide extends FlutterDeckSlideWidget {
  const FaceSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/face',
            title: 'Face',
            speakerNotes: _speakerNotes,
            steps: 3,
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
    const widthFactor = 0.9;
    return FlutterDeckSlideStepsBuilder(
      builder: (context, step) {
        return AnimatedVerticalCarousel(
          step: step - 1,
          fitHeight: true,
          children: const [
            _Code(),
            StretchedColumn(
              widthFactor: widthFactor,
              children: [
                FittedText('Renan'),
                FittedText('Araujo'),
              ],
            ),
            StretchedColumn(
              widthFactor: widthFactor,
              children: [
                FittedText('Raouf'),
                FittedText('Rahiche'),
              ],
            ),
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
    return Image.asset('assets/paint_face.png');
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
          children: const [
            _Preview(),
            _Speaker(index: 14),
            _Speaker(index: 13),
          ],
        );
      },
    );
  }
}

class _Preview extends StatelessWidget {
  const _Preview();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: HappySparkles(
        image: null,
        particles: [],
        mousePosition: Offset.zero,
        controller: null,
        drawMode: HappySparklesDrawMode.onlyFace,
      ),
    );
  }
}

class _Speaker extends StatelessWidget {
  const _Speaker({
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.75,
        heightFactor: 0.75,
        child: Speaker(index: index),
      ),
    );
  }
}
