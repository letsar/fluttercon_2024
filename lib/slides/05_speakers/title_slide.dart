import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/templates/title_slide_template.dart';

const _speakerNotes = '''
''';

class SpeakersTitleSlide extends TitleSlideTemplate {
  const SpeakersTitleSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/speakers-title',
            title: 'The Speakers',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
          texts: const ['The Speakers'],
        );
}
