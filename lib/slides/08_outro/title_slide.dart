import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/templates/title_slide_template.dart';

const _speakerNotes = '''
Let's do a quick recap.
''';

class OutroTitleSlide extends TitleSlideTemplate {
  const OutroTitleSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/outro-title',
            title: 'Recap title',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
          texts: const ['Recap'],
        );
}
