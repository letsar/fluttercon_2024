import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/templates/quote_slide.dart';

const _speakerNotes = '''
One thing to remember with that API is this quote from our beloved Flutter Yoda.
''';

class SaveYodaQuoteSlide extends FlutterDeckSlideWidget {
  const SaveYodaQuoteSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/save-yoda',
            title: 'Canvas.save yoda quote',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const QuoteSlide(
          quote: '''
Always two there are.
No more, no less.
A save and a restore method.''',
          attribution: 'Flutter Yoda',
        );
      },
    );
  }
}
