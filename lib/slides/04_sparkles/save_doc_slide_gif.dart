import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
When I first read this documentation I didn't really understand what it was supposing to do.
Let's see an example of what's going on here.
''';

class SaveDocGifSlide extends FlutterDeckSlideWidget {
  const SaveDocGifSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/save-doc-gif',
            title: 'Canvas.save doc GIF',
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
            'assets/what_gif.webp',
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}
