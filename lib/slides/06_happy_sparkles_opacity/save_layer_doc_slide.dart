import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/templates/quote_slide.dart';

const _speakerNotes = '''
Once again, let's look at the Flutter documentation to understand what is the goal of this method.

Yeah, don't bother to read it.
''';

class SaveLayerDocSlide extends FlutterDeckSlideWidget {
  const SaveLayerDocSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/save-layer-doc',
            title: 'Canvas.saveLayer doc',
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
clip on the save stack
and then creates a new group
which subsequent calls will become a part of.
When the save stack is later popped, the group will be 
flattened into a layer and have the given `paint`'s [Paint.colorFilter] and [Paint.blendMode] applied...''',
          attribution: 'Flutter documentation',
        );
      },
    );
  }
}
