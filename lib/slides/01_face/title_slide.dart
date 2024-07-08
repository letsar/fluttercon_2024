import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/templates/title_slide_template.dart';

const _speakerNotes = '''

''';

class FaceTitleSlide extends TitleSlideTemplate {
  const FaceTitleSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/face-title',
            title: 'The Face',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
          texts: const ['The Face'],
        );
}
