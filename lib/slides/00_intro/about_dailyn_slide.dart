import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttercon_2024/utils/colors.dart';
import 'package:fluttercon_2024/utils/fitted_text.dart';
import 'package:fluttercon_2024/utils/stretched_column.dart';
import 'package:fluttercon_2024/utils/vertical_carousel.dart';

const _speakerNotes = '''
gamified payment system where users earn cashback when they pay in local businesses
''';

class AboutDailynSlide extends FlutterDeckSlideWidget {
  const AboutDailynSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/about-dailyn',
            title: 'About Dailyn',
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
                FittedText('The Payment'),
                FittedText('App', color: BrandColors.informative),
              ],
            ),
            StretchedColumn(
              widthFactor: widthFactor,
              children: [
                FittedText('That'),
                FittedText('saves you'),
                FittedText('money', color: BrandColors.positive),
              ],
            ),
            StretchedColumn(
              widthFactor: widthFactor,
              children: [
                RowFittedText(
                  children: [
                    FittedText('in '),
                    FittedText('local', color: BrandColors.warning),
                  ],
                ),
                FittedText(
                  'businesses',
                  color: BrandColors.warning,
                ),
              ],
            ),
            StretchedColumn(
              widthFactor: widthFactor,
              children: [
                FittedText('available in'),
                FittedText('the north of'),
                _France(),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _France extends StatelessWidget {
  const _France();

  @override
  Widget build(BuildContext context) {
    const blue = BrandColors.informative;
    const white = Color(0xFFFFFFFF);
    const red = BrandColors.negative;

    return const RowFittedText(
      children: [
        FittedText('FR', color: blue),
        FittedText('AN', color: white),
        FittedText('CE', color: red),
      ],
    );
  }
}

class _Right extends StatelessWidget {
  const _Right();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FractionallySizedBox(
          widthFactor: 0.4,
          child: LayoutBuilder(builder: (context, constraints) {
            return SvgPicture.asset(
              'assets/logo_dailyn.svg',
              width: constraints.maxWidth,
              colorFilter: const ColorFilter.mode(
                BrandColors.onNeutral,
                BlendMode.srcIn,
              ),
            );
          }),
        ),
        const Expanded(child: _Images()),
      ],
    );
  }
}

class _Images extends StatelessWidget {
  const _Images();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _Image(name: 'dailyn'),
        _Image(name: 'dailyn_01'),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/$name.webp');
  }
}
