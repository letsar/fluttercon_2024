import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/fitted_text.dart';
import 'package:fluttercon_2024/utils/happy_sparkles.dart';
import 'package:fluttercon_2024/utils/stretched_column.dart';

const _speakerNotes = '''
This is all for today. I hope you enjoyed the talk and you learnt something new!
If you have questions and if we have time, I will be pleased to answer them.
''';

class ThankYouSlide extends FlutterDeckSlideWidget {
  const ThankYouSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/thank-you',
            title: 'Thank you!',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) {
        return const _AnimatedEmoji();
      },
      rightBuilder: (context) {
        return const _Feedback();
      },
    );
  }
}

class _AnimatedEmoji extends StatefulWidget {
  const _AnimatedEmoji();

  @override
  State<_AnimatedEmoji> createState() => _AnimatedEmojiState();
}

class _AnimatedEmojiState extends State<_AnimatedEmoji>
    with SingleTickerProviderStateMixin {
  ui.Image? image;
  late final controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  );
  final particles = <Particle>[];
  final random = math.Random();
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

  void addParticles(Offset position) {
    final count = random.nextInt(6) + 4;
    for (int i = 0; i < count; i++) {
      particles.add(Particle.fromPosition(position, random));
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        addParticles(event.localPosition);
        setState(() {
          mousePosition = event.localPosition;
        });
      },
      child: HappySparkles(
        image: image,
        particles: particles,
        mousePosition: mousePosition,
        controller: controller,
        drawMode: HappySparklesDrawMode.allWithMessage,
      ),
    );
  }
}

class _Feedback extends StatelessWidget {
  const _Feedback();

  @override
  Widget build(BuildContext context) {
    return StretchedColumn(
      widthFactor: 0.7,
      children: [
        const FittedText('Feedback?'),
        Image.asset('assets/exported_qrcode_image_600.png'),
        const FittedText('@lets4r', horizontalPadding: 100),
      ],
    );
  }
}
