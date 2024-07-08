import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/templates/title_slide_template.dart';

const _speakerNotes = '''
So, today, I will show you some tips to improve your Flutter painting skills, using a CustomPaint widget.
''';

class PaintingTipsTitleSlide extends TitleSlideTemplate {
  const PaintingTipsTitleSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/paint-tips',
            title: 'Painting Tips',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
          widthFactor: 0.75,
          texts: const ['Painting', 'Tips'],
        );
}
