import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/templates/title_slide_template.dart';

const _speakerNotes = '''
''';

class MouthTitleSlide extends TitleSlideTemplate {
  const MouthTitleSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/mouth-title',
            title: 'The Mouth',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
          texts: const ['The Mouth'],
        );
}
