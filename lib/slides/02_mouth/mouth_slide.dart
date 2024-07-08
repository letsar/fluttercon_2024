import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/happy_sparkles.dart';

const _speakerNotes = '''
Nothing fancy for its mouth, we create a rounded rectangle but with different corner radius between the top and bottome ones.
''';

class MouthSlide extends FlutterDeckSlideWidget {
  const MouthSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/mouth',
            title: 'Mouth',
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
    return Image.asset('assets/paint_mouth.png');
  }
}

class _Preview extends StatelessWidget {
  const _Preview();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFFFFFFFF),
      child: Padding(
        padding: EdgeInsets.all(32),
        child: HappySparkles(
          image: null,
          particles: [],
          mousePosition: Offset.zero,
          controller: null,
          drawMode: HappySparklesDrawMode.onlyMouth,
        ),
      ),
    );
  }
}
