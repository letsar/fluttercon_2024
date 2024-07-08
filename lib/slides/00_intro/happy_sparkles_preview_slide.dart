import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/happy_sparkles.dart';

const _speakerNotes = '''
Say hello to my buddy! It is amazed by all the talks we have here at FlutterCon!

We will dive into parts of its code to teach you how to do it.

PRESENT WHAT WE CAN DO
''';

class HappySparklesPreviewSlide extends FlutterDeckSlideWidget {
  const HappySparklesPreviewSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/happy-sparles-preview',
            title: 'Happy Sparkles Preview',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(builder: (context) {
      return const HappySparklesPreview();
    });
  }
}

class HappySparklesPreview extends StatefulWidget {
  const HappySparklesPreview({
    super.key,
    this.drawMode,
  });

  final HappySparklesDrawMode? drawMode;

  @override
  State<HappySparklesPreview> createState() => _HappySparklesPreviewState();
}

class _HappySparklesPreviewState extends State<HappySparklesPreview>
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
        drawMode: widget.drawMode ?? HappySparklesDrawMode.all,
      ),
    );
  }
}
