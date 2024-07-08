import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttercon_2024/utils/colors.dart';
import 'package:fluttercon_2024/utils/fitted_text.dart';
import 'package:fluttercon_2024/utils/painted_image.dart';
import 'package:fluttercon_2024/utils/stretched_column.dart';
import 'package:fluttercon_2024/utils/vertical_carousel.dart';

const _speakerNotes = '''
But first, let me introduce myself. I'm Romain Rastel. I'm currently Lead Developer at Dailyn. I have been working as a French Software Engineer for 13 years now and my love story with Flutter started at the end of 2017 (Twenty Seventeen) (almost 7 years ago, now!).
I have created and I have been maintaining open source packages
I also wrote some articles, and I spoke in Developer conferences like this one.
''';

class AboutMeSlide extends FlutterDeckSlideWidget {
  const AboutMeSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/about-me',
            title: 'About me',
            steps: 4,
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
    const widthFactor = 0.9;
    return FlutterDeckSlideStepsBuilder(
      builder: (context, step) {
        return AnimatedVerticalCarousel(
          step: step - 1,
          children: const [
            StretchedColumn(
              widthFactor: widthFactor,
              children: [
                FittedText(
                  'Flutter',
                  color: BrandColors.informative,
                ),
                FittedText('Lead Dev'),
                _DailynLogo(),
              ],
            ),
            StretchedColumn(
              widthFactor: widthFactor,
              children: [
                RowFittedText(children: [
                  FittedText('13 ', color: BrandColors.negative),
                  FittedText('years'),
                ]),
                FittedText('of XP in'),
                FittedText(
                  'Software',
                  color: BrandColors.negative,
                ),
                FittedText(
                  'Development',
                  color: BrandColors.negative,
                ),
              ],
            ),
            StretchedColumn(
              widthFactor: widthFactor,
              children: [
                RowFittedText(children: [
                  FittedText('7 ', color: BrandColors.informative),
                  FittedText('years'),
                ]),
                FittedText('of XP in'),
                FittedText(
                  'Flutter',
                  color: BrandColors.informative,
                ),
              ],
            ),
            StretchedColumn(
              widthFactor: widthFactor,
              children: [
                FittedText(
                  'Open',
                  color: FlutterColors.green,
                ),
                FittedText(
                  'Source',
                  color: FlutterColors.green,
                ),
                FittedText('Contributor'),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _DailynLogo extends StatelessWidget {
  const _DailynLogo();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SvgPicture.asset(
        'assets/logo_dailyn.svg',
        width: constraints.maxWidth,
        colorFilter: const ColorFilter.mode(
          BrandColors.onNeutral,
          BlendMode.srcIn,
        ),
      );
    });
  }
}

class _Right extends StatelessWidget {
  const _Right();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        PaintedEffect(
          child: _Image(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: StretchedColumn(
            widthFactor: 0.8,
            alignment: Alignment.topCenter,
            children: [
              FittedText('Romain'),
              FittedText('Rastel'),
            ],
          ),
        ),
      ],
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
