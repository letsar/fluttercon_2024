import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/templates/title_slide_template.dart';

const _speakerNotes = '''
''';

class EyesTitleSlide extends TitleSlideTemplate {
  const EyesTitleSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/eyes-title',
            title: 'The Eyes',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
          texts: const ['The Eyes'],
        );
}
