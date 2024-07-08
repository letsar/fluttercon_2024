import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/templates/quote_slide.dart';

const _speakerNotes = '''
Well well well
''';

class SaveDocSlide extends FlutterDeckSlideWidget {
  const SaveDocSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/save-doc',
            title: 'Canvas.save doc',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const QuoteSlide(
          quote: '''Saves a copy of the
current transform and
clip on the save stack.
Call restore to pop the save stack''',
          attribution: 'Flutter documentation',
        );
      },
    );
  }
}
