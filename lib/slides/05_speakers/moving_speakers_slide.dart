import 'dart:ui' as ui;

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/colors.dart';
import 'package:fluttercon_2024/utils/fitted_text.dart';
import 'package:fluttercon_2024/utils/happy_sparkles.dart';
import 'package:fluttercon_2024/utils/image_part.dart';
import 'package:fluttercon_2024/utils/stretched_column.dart';
import 'package:fluttercon_2024/utils/vertical_carousel.dart';

const _speakerNotes = '''
Multiple ways to achieve that with a CustomPainter.

1. Each Image own file => DrawImage
2. Don't want to draw the whole image (SpriteSheet) => DrawImageRect
3. Batch operations => DrawAtlas
4. Best performance => DrawRawAtlas

To call drawAtlas we need multiple things.
1. The sprite sheet (called spriteSheet here). You can see at the right the spriteSheet I used.
This is a line of 21 speakers. Each speaker is 400 by 400 pixels.

2. A list containing all the rectangles representing the part of the spriteSheet we want to draw.
For example let's draw the speaker number 9, Mangirdas Kazlauskas, who by the way, is the creator of FlutterDeck, which I used to make this presentation.
In this case we need to provide this rectangle.

3. Then we need to tell where to draw on the screen, the rectangles we provided. We do that trough a list of RSTransforms.
An RSTransform allows us to scale, rotate and translate the part of the sprite sheet we want to draw.
For example if we want to draw Mangirdas at the (0,0) offset,with a size of 800 by 800 pixels, we will create an RSTransform with a scale of 2.

The computation of the offset is hidden here, because it involves a lot of math and it's too early for that.
4. The last thing we need is A paint object to tell how to draw the images. Here for example I want my speakers to be a little transparent.

This is not all, you can pass if you want a list of colors to apply different colors to each part of the image and a blend mode.

(last one cull rect for optimization).
''';

class MovingSpeakersSlide extends FlutterDeckSlideWidget {
  const MovingSpeakersSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/moving-speakers',
            title: 'Moving Speakers',
            steps: 9,
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
    return FlutterDeckSlideStepsBuilder(
      builder: (context, step) {
        return AnimatedVerticalCarousel(
          step: step - 1,
          fitHeight: true,
          children: const [
            SizedBox.expand(),
            _MemePart(
              step: 1,
              texts: ['Draw', 'Image'],
            ),
            _MemePart(
              step: 2,
              texts: ['Draw', 'Image', 'Rect'],
            ),
            _MemePart(
              step: 3,
              texts: ['Draw', 'Atlas'],
            ),
            _MemePart(
              step: 5,
              texts: ['Draw', 'Raw', 'Atlas'],
            ),
            _Code(),
          ],
        );
      },
    );
  }
}

class _MemePart extends StatelessWidget {
  const _MemePart({
    required this.step,
    required this.texts,
  });

  final int step;
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/galaxy-brain-f-stage-$step.png',
          fit: BoxFit.cover,
        ),
        Opacity(
          opacity: 0.7,
          child: StretchedColumn(
            widthFactor: 0.9,
            children: texts.map((e) => FittedText(e)).toList(),
          ),
        ),
      ],
    );
  }
}

class _Code extends StatelessWidget {
  const _Code();

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/paint_moving_speakers.png');
  }
}

class _Right extends StatelessWidget {
  const _Right();

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlideStepsBuilder(
      builder: (context, step) {
        final effectiveStep = switch (step) {
          < 7 => 0,
          _ => step,
        };
        return AnimatedVerticalCarousel(
          step: effectiveStep,
          fitHeight: true,
          children: [
            const MovingSpeakersPreview(),
            _DrawAtlasExplanation(
              step: effectiveStep,
            ),
          ],
        );
      },
    );
  }
}

class MovingSpeakersPreview extends StatefulWidget {
  const MovingSpeakersPreview({
    super.key,
  });

  @override
  State<MovingSpeakersPreview> createState() => _MovingSpeakersPreviewState();
}

class _MovingSpeakersPreviewState extends State<MovingSpeakersPreview>
    with SingleTickerProviderStateMixin {
  ui.Image? image;
  late final controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  );
  var mousePosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    controller.repeat(reverse: false);
    loadImage();
  }

  void loadImage() async {
    final data = await rootBundle.load('assets/speakers.png');
    final bytes = data.buffer.asUint8List();
    image = await decodeImageFromList(bytes);
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: HappySparkles(
        image: image,
        particles: const [],
        mousePosition: Offset.zero,
        controller: controller,
        drawMode: HappySparklesDrawMode.onlySpeakers,
      ),
    );
  }
}

class _DrawAtlasExplanation extends StatelessWidget {
  const _DrawAtlasExplanation({
    required this.step,
  });

  final int step;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedOpacity(
          opacity: step > 6 ? 1 : 0,
          duration: const Duration(milliseconds: 400),
          child: const _DrawAtlasSpriteSheet(),
        ),
        const SizedBox(height: 32),
        AnimatedOpacity(
          opacity: step > 7 ? 1 : 0,
          duration: const Duration(milliseconds: 400),
          child: const _DrawAtlasRects(),
        ),
        const SizedBox(height: 32),
        AnimatedOpacity(
          opacity: step > 8 ? 1 : 0,
          duration: const Duration(milliseconds: 400),
          child: const _DrawAtlasTransforms(),
        ),
      ],
    );
  }
}

class _DrawAtlasSpriteSheet extends StatelessWidget {
  const _DrawAtlasSpriteSheet();

  @override
  Widget build(BuildContext context) {
    final deckTheme = FlutterDeckTheme.of(context);
    final textStyle = deckTheme.textTheme.display.copyWith(
      fontSize: 36,
      fontWeight: FontWeight.normal,
      height: 1,
      shadows: [
        const Shadow(
          color: DeckColors.eerieBlack,
          offset: Offset(8, 8),
          blurRadius: 8,
        ),
      ],
    );

    return Column(
      children: [
        const SizedBox(
          height: 64,
          child: FittedText('Sprite Sheet'),
        ),
        const SizedBox(height: 16),
        Image.asset('assets/speakers.png'),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < 21; i++)
              Expanded(
                child: Center(
                  child: Text(
                    i.toString(),
                    style: textStyle,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _DrawAtlasRects extends StatelessWidget {
  const _DrawAtlasRects();

  @override
  Widget build(BuildContext context) {
    final deckTheme = FlutterDeckTheme.of(context);
    final textStyle = deckTheme.textTheme.display.copyWith(
      fontSize: 36,
      fontWeight: FontWeight.normal,
      height: 1,
      shadows: [
        const Shadow(
          color: DeckColors.eerieBlack,
          offset: Offset(8, 8),
          blurRadius: 8,
        ),
      ],
    );

    return Column(
      children: [
        const SizedBox(
          height: 64,
          child: FittedText('Rects'),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 200,
              width: 200,
              child: Speaker(index: 9),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Left: 400 * 9 = 3600'.toUpperCase(), style: textStyle),
                const SizedBox(height: 16),
                Text('Top: 0'.toUpperCase(), style: textStyle),
                const SizedBox(height: 16),
                Text('Width: 400'.toUpperCase(), style: textStyle),
                const SizedBox(height: 16),
                Text('Height: 400'.toUpperCase(), style: textStyle),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _DrawAtlasTransforms extends StatelessWidget {
  const _DrawAtlasTransforms();

  @override
  Widget build(BuildContext context) {
    final deckTheme = FlutterDeckTheme.of(context);
    final textStyle = deckTheme.textTheme.display.copyWith(
      fontSize: 36,
      fontWeight: FontWeight.normal,
      height: 1,
      shadows: [
        const Shadow(
          color: DeckColors.eerieBlack,
          offset: Offset(8, 8),
          blurRadius: 8,
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 64,
          child: FittedText('Transforms'),
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 400,
              width: 400,
              child: Speaker(index: 9),
            ),
            Text(
              '(Scale: 2, translateX: 0, translateY: 0),'.toUpperCase(),
              style: textStyle,
            ),
          ],
        ),
      ],
    );
  }
}
