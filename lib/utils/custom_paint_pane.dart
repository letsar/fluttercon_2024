import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/vertical_carousel.dart';

class CustomPaintPane extends StatelessWidget {
  const CustomPaintPane({
    super.key,
    required this.step,
    required this.title,
    this.subtitle,
    required this.painter,
    required this.codeFileName,
    this.paintScale,
    this.child,
  });

  final int step;
  final String title;
  final Widget? subtitle;
  final CustomPainter painter;
  final String codeFileName;
  final Widget? child;
  final double? paintScale;

  @override
  Widget build(BuildContext context) {
    final localSubtitle = subtitle;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: FlutterDeckTheme.of(context).textTheme.title),
        if (localSubtitle != null) ...[
          const SizedBox(height: 8),
          localSubtitle
        ],
        const SizedBox(height: 24),
        Expanded(
          child: AnimatedVerticalCarousel(
            fitHeight: true,
            step: step,
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ColoredBox(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: CustomPaint(
                        painter: painter,
                        child: child ?? const SizedBox.expand(),
                      ),
                    ),
                  ),
                ),
              ),
              Image.asset('assets/$codeFileName.png'),
            ],
          ),
        ),
      ],
    );
  }
}
