import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/templates/title_slide_template.dart';

const _speakerNotes = '''
Let me introduce you a big friend of mine: Happy Sparkles!
''';

class HappySparklesSlide extends TitleSlideTemplate {
  const HappySparklesSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/happy-sparkles',
            title: 'Happy Sparkles',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
          texts: const ['Happy', 'Sparkles'],
        );
}
