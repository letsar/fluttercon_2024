import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/templates/quote_slide.dart';

const _speakerNotes = '''
But... there is a but. We need to be careful with this power.
''';

class SaveLayerResponsibilitiesSlide extends FlutterDeckSlideWidget {
  const SaveLayerResponsibilitiesSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/save-layer-responsibilities',
            title: 'Canvas.saveLayer responsibilities',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const QuoteSlide(
          quote: '''With great power
there must also come
great responsibility!''',
          attribution:
              'Stan Lee (but widely attributed to Uncle Ben in Spiderman)',
        );
      },
    );
  }
}
