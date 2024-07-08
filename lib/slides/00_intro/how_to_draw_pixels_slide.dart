import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/colors.dart';
import 'package:fluttercon_2024/utils/fitted_text.dart';
import 'package:fluttercon_2024/utils/painted_image.dart';
import 'package:fluttercon_2024/utils/stretched_column.dart';
import 'package:fluttercon_2024/utils/vertical_carousel.dart';

const _speakerNotes = '''
I said that one of the main reasons I love Flutter is the ability to manipulate pixels. And we have at least two entry points in Flutter for that.
At the widget level we have the CustomPaint widget 
I pretty sure that a lot of you already used this widget in the past. In fact let's do a quick survey, raise your hand if you ever used a CustomPaint widget?

That's what I thought.

And at the rendering one, well we can paint on the screen through RenderObjects.
I won't go through the details of RenderObjects here, this not the topic of today. But if you want to know more about them, I gave a talk, here, last year about how they can make your lives easier.
''';

class WhereToDrawPixelsSlide extends FlutterDeckSlideWidget {
  const WhereToDrawPixelsSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/how-to-draw-pixels',
            title: 'How to draw pixels with Flutter',
            steps: 3,
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) {
        return const _Left();
      },
      rightBuilder: (context) {
        return const _Right();
      },
    );
  }
}

class _Left extends StatelessWidget {
  const _Left();

  @override
  Widget build(BuildContext context) {
    return const StretchedColumn(
      widthFactor: 0.9,
      children: [
        FittedText('How to draw'),
        FittedText('pixels', color: BrandColors.warning),
        FittedText('on the screen'),
        FittedText('with', horizontalPadding: 200),
        FittedText('Flutter', color: BrandColors.informative),
      ],
    );
  }
}

class _Right extends StatelessWidget {
  const _Right();

  @override
  Widget build(BuildContext context) {
    const widthFactor = 0.95;
    return Center(
      child: FlutterDeckSlideStepsBuilder(
        builder: (context, step) {
          return AnimatedVerticalCarousel(
            step: step - 1,
            fitHeight: true,
            children: const [
              StretchedColumn(
                widthFactor: widthFactor,
                children: [
                  FittedText('?'),
                ],
              ),
              StretchedColumn(
                widthFactor: widthFactor,
                children: [
                  FittedText('Custom'),
                  FittedText('Paint'),
                ],
              ),
              StretchedColumn(
                widthFactor: widthFactor,
                children: [
                  FittedText('Render'),
                  FittedText('Object'),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AnimatedOilPainting extends StatefulWidget {
  const _AnimatedOilPainting();

  @override
  State<_AnimatedOilPainting> createState() => _AnimatedOilPaintingState();
}

class _AnimatedOilPaintingState extends State<_AnimatedOilPainting>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  );

  late final animation = ReverseAnimation(controller);

  @override
  void initState() {
    super.initState();
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return PaintedEffect(
          opacity: animation.value,
          child: child!,
        );
      },
      child: const _Image(),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/speaker.jpg',
      height: double.infinity,
      fit: BoxFit.fitHeight,
    );
  }
}
