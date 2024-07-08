import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/happy_sparkles.dart';

const _speakerNotes = '''
But what I want to show you is how to repaint your painter when some of its properties change. Our painter saves the mouse position and it repaints when the position changes, thanks to the shouldRepaint method. 
''';

class MovingEyesSlide extends FlutterDeckSlideWidget {
  const MovingEyesSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/moving-eyes',
            title: 'Moving Eyes',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) {
        return const _Code();
      },
      rightBuilder: (context) {
        return const MovingEyesPreview();
      },
    );
  }
}

class _Code extends StatelessWidget {
  const _Code();

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/paint_moving_eyes.png');
  }
}

class MovingEyesPreview extends StatefulWidget {
  const MovingEyesPreview({
    super.key,
  });

  @override
  State<MovingEyesPreview> createState() => _MovingEyesPreviewState();
}

class _MovingEyesPreviewState extends State<MovingEyesPreview> {
  Offset mousePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: MouseRegion(
        onHover: (event) {
          setState(() {
            mousePosition = event.localPosition;
          });
        },
        child: HappySparkles(
          image: null,
          particles: const [],
          mousePosition: mousePosition,
          controller: null,
          drawMode: HappySparklesDrawMode.onlyEyes,
        ),
      ),
    );
  }
}
