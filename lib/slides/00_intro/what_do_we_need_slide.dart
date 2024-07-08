import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/colors.dart';
import 'package:fluttercon_2024/utils/credited_image.dart';
import 'package:fluttercon_2024/utils/fitted_text.dart';
import 'package:fluttercon_2024/utils/painted_image.dart';
import 'package:fluttercon_2024/utils/stretched_column.dart';
import 'package:fluttercon_2024/utils/vertical_carousel.dart';

const _speakerNotes = '''
We need a canvas and we have a class named Canvas which representing exactly that.
We also need tools, brushes, colors. This is the role of the class named Paint.
The last thing we need is primitives to tell what to do. Do we want to draw a circle, paint individual pixels and so on. The Canvas class has methods for that.
''';

class WhatDoWeNeedSlide extends FlutterDeckSlideWidget {
  const WhatDoWeNeedSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/what-do-we-need',
            title: 'What do we need to paint?',
            steps: 7,
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
        FittedText('What do we need to'),
        FittedText('paint', color: BrandColors.warning),
        FittedText('pixels on the'),
        FittedText('screen'),
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
          final verticalStep = switch (step) {
            > 5 => 3,
            > 3 => 2,
            > 1 => 1,
            _ => 0,
          };

          return AnimatedVerticalCarousel(
            step: verticalStep,
            fitHeight: true,
            children: [
              const StretchedColumn(
                widthFactor: widthFactor,
                children: [
                  FittedText('?'),
                ],
              ),
              _AnimatedOpacityStack(
                showForeground: step > 2,
                background: const CreditedImage(
                  image: 'canvas_justyn-warner.jpg',
                  credits: 'Justyn Warner on Unsplash',
                ),
                foreground: const StretchedColumn(
                  widthFactor: widthFactor,
                  children: [
                    FittedText('Canvas', color: BrandColors.informative),
                    FittedText('Class'),
                  ],
                ),
              ),
              _AnimatedOpacityStack(
                showForeground: step > 4,
                background: const CreditedImage(
                  image: 'paint_andres-perez.jpg',
                  credits: 'Andres Perez on Unsplash',
                ),
                foreground: const StretchedColumn(
                  widthFactor: widthFactor,
                  children: [
                    FittedText('Paint', color: BrandColors.positive),
                    FittedText('Class'),
                  ],
                ),
              ),
              _AnimatedOpacityStack(
                showForeground: step > 6,
                background: const CreditedImage(
                  image: 'methods_dillon-wanner.jpg',
                  credits: 'Dillon Wanner on Unsplash',
                ),
                foreground: const StretchedColumn(
                  widthFactor: widthFactor,
                  children: [
                    FittedText('Methods', color: BrandColors.negative),
                    FittedText('on the Canvas class'),
                  ],
                ),
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

class _AnimatedOpacityStack extends StatelessWidget {
  const _AnimatedOpacityStack({
    required this.showForeground,
    required this.background,
    required this.foreground,
  });

  final bool showForeground;
  final Widget background;
  final Widget foreground;

  @override
  Widget build(BuildContext context) {
    final backgroundOpacity = showForeground ? 0.36 : 1.0;
    final foregroundOpacity = showForeground ? 1.0 : 0.0;
    const duration = Duration(milliseconds: 500);

    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedOpacity(
          opacity: backgroundOpacity,
          duration: duration,
          child: background,
        ),
        AnimatedOpacity(
          opacity: foregroundOpacity,
          duration: duration,
          child: foreground,
        ),
      ],
    );
  }
}
