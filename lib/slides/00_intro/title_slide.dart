import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/colors.dart';
import 'package:fluttercon_2024/utils/fitted_text.dart';
import 'package:fluttercon_2024/utils/painted_image.dart';
import 'package:fluttercon_2024/utils/stretched_column.dart';

const _speakerNotes = '''
Hello everyone and thank you for being here!

I love Flutter for a lot of reasons, one of them is the ability to manipulate pixels on the screen. I mean, to me it was the first multi-platform framework, where I could finally say YES to pretty much anything to the designers. This is a framework where designers can really express themselves and let's see together how to enhance your Flutter painting skills!
''';

class TitleSlide extends FlutterDeckSlideWidget {
  const TitleSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/title',
            title: 'Enhance your Flutter painting skills',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const _Slide();
      },
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _Background(),
        _Title(),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: StretchedColumn(
        widthFactor: 0.4,
        children: [
          FittedText('Enhance'),
          FittedText('Your'),
          FittedText('Flutter', color: BrandColors.secondary),
          FittedText('Painting', color: BrandColors.secondary),
          FittedText('Skills!'),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: DeckColors.eerieBlack,
      child: Center(
        child: PaintedImage(
          path: 'assets/dashatars.png',
          opacity: 0.6,
        ),
      ),
    );
  }
}
