import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/templates/quote_slide.dart';

const _speakerNotes = '''
I won't go into details here. You can read the Flutter documentation if you want
to know more about it. But it is not a cheap operation.
''';

class SaveLayerDocPerformanceSlide extends FlutterDeckSlideWidget {
  const SaveLayerDocPerformanceSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/save-layer-doc-preformance',
            title: 'Canvas.saveLayer doc perf',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const QuoteSlide(
          quote: '''Generally speaking,
saveLayer is relatively
expensive''',
          attribution: 'Flutter documentation',
        );
      },
    );
  }
}
