import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
This is exactly what happened when I first read the saveLayer method documentation.

I always need examples to realy grasp the concepts and that what we will do next.
''';

class SaveLayerDocGifSlide extends FlutterDeckSlideWidget {
  const SaveLayerDocGifSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/save-layer-doc-gif',
            title: 'Canvas.saveLayer doc GIF',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) {
        return SizedBox.expand(
          child: Image.asset(
            'assets/whaaaat.webp',
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}
