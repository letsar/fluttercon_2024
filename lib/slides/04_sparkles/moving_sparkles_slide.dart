import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/happy_sparkles.dart';
import 'package:fluttercon_2024/utils/vertical_carousel.dart';

const _speakerNotes = '''
So Let's dive into the code:

First part not interesting. Except blur.

Explain code.

Line 12 => only for the rotation effect 

We draw the next sparkle at THE SAME OFFSET, and we continue to rotate the canvas.
NO SINUS, NO COSINUS, NO MATRIX MULTIPLICATION, NO MATH HERE.

Finally we restore the canvas to its previous state.

Another interesting thing I want to show you is how to automatically repaint with an animation.
We can pass a Listenable to the repaint property of the CustomPainter.
By doing that, the CustomPainter will listen to the Listenable and repaint when it changes.
''';

class MovingSparklesSlide extends FlutterDeckSlideWidget {
  const MovingSparklesSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/emoji-moving-sparkles',
            title: 'Moving Sparkles',
            speakerNotes: _speakerNotes,
            steps: 2,
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
        return const MovingSparklesPreview();
      },
    );
  }
}

class _Code extends StatelessWidget {
  const _Code();

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlideStepsBuilder(
      builder: (context, step) {
        return AnimatedVerticalCarousel(
          step: step - 1,
          fitHeight: true,
          children: [
            Image.asset('assets/paint_sparkles.png'),
            Image.asset('assets/paint_moving_sparkles.png'),
          ],
        );
      },
    );
  }
}

class MovingSparklesPreview extends StatefulWidget {
  const MovingSparklesPreview({
    super.key,
  });

  @override
  State<MovingSparklesPreview> createState() => _MovingSparklesPreviewState();
}

class _MovingSparklesPreviewState extends State<MovingSparklesPreview>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  );

  @override
  void initState() {
    super.initState();
    controller.repeat(reverse: false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlideStepsBuilder(builder: (context, step) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: HappySparkles(
          image: null,
          particles: const [],
          mousePosition: Offset.zero,
          controller: step == 1 ? null : controller,
          drawMode: HappySparklesDrawMode.onlySparkles,
        ),
      );
    });
  }
}
