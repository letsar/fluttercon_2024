import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/templates/title_slide_template.dart';

const _speakerNotes = '''
''';

class ParticlesTitleSlide extends TitleSlideTemplate {
  const ParticlesTitleSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/particles-title',
            title: 'The Particles',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
          texts: const ['The Particles'],
        );
}
