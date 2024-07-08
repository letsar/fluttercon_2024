import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/happy_sparkles.dart';

const _speakerNotes = '''
The eyes are pretty simples, it's just two circles for each one.
We have some math here to position the black circle so that it will be aligned with the mouse position and the eye's center.
''';

class EyesSlide extends FlutterDeckSlideWidget {
  const EyesSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/eyes',
            title: 'Eyes',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) {
        return const _Code();
      },
      rightBuilder: (context) {
        return const _Preview();
      },
    );
  }
}

class _Code extends StatelessWidget {
  const _Code();

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/paint_eyes.png');
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
        drawMode: HappySparklesDrawMode.onlyEyes,
      ),
    );
  }
}
