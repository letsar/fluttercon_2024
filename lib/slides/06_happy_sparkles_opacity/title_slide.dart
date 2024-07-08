import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/templates/title_slide_template.dart';

const _speakerNotes = '''
Another interesting particularity of my buddy here, is how its face is a little transparent.
''';

class SparklesOpacityTitleSlide extends TitleSlideTemplate {
  const SparklesOpacityTitleSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/sparkles-opacity-title',
            title: 'Sparkles\'s Opacity',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
          texts: const ['Sparkles\'s Opacity'],
        );
}
