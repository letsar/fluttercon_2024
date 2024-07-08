import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/templates/title_slide_template.dart';

const _speakerNotes = '''
Let's see how to put sparkles into your lives.
''';

class SparklesTitleSlide extends TitleSlideTemplate {
  const SparklesTitleSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/sparkles-title',
            title: 'The Sparkles',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
          texts: const ['The Sparkles'],
        );
}
