import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck/src/templates/split_slide.dart';
import 'package:fluttercon_2024/utils/colors.dart';
import 'package:fluttercon_2024/utils/custom_paint_pane.dart';

const _speakerNotes = '''
So let's look at a simplified example with overlapping colors.
We have the same colored squares at the left and at the right.
But we use the color opacity of the paint at the left, and saveLayer at the right.

When we reduce the opacity, we can see that, at the left the colors are mixed up
in the overlapping corners of the red square.
But with saveLayer everything is opacified at the same time.
''';

class SaveLayerColorSlide extends FlutterDeckSlideWidget {
  const SaveLayerColorSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/save-layer-color',
            title: 'Canvas.saveLayer Color',
            steps: 2,
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
            header: FlutterDeckHeaderConfiguration(title: 'Opacity effect'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const _Slide();
      },
    );
  }
}

class _Slide extends StatefulWidget {
  const _Slide();

  @override
  State<_Slide> createState() => _SlideState();
}

class _SlideState extends State<_Slide> {
  final opacity = ValueNotifier<double>(1.0);

  @override
  void initState() {
    super.initState();
    opacity.addListener(onChangeOpacity);
  }

  void onChangeOpacity() {
    setState(() {});
  }

  @override
  void dispose() {
    opacity.removeListener(onChangeOpacity);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterDeckSplitSlide(
          leftBuilder: (context) {
            return _WithoutSaveLayer(
              opacity: opacity.value,
            );
          },
          rightBuilder: (context) {
            return _WithSaveLayer(
              opacity: opacity.value,
            );
          },
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ColoredBox(
            color: Colors.black.withOpacity(0.6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Opacity',
                  style: FlutterDeckTheme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  width: 300,
                  child: Slider(
                    label: 'Opacity',
                    min: 0.0,
                    max: 1.0,
                    onChanged: (value) {
                      opacity.value = value;
                    },
                    value: opacity.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WithSaveLayer extends StatelessWidget {
  const _WithSaveLayer({
    required this.opacity,
  });

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlideStepsBuilder(
      builder: (context, step) {
        return CustomPaintPane(
          step: step - 1,
          title: 'With saveLayer',
          painter: _WithSaveLayerPainter(opacity: opacity),
          codeFileName: 'opacity_with_save_layer',
        );
      },
    );
  }
}

class _WithoutSaveLayer extends StatelessWidget {
  const _WithoutSaveLayer({
    required this.opacity,
  });

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlideStepsBuilder(
      builder: (context, step) {
        return CustomPaintPane(
          step: step - 1,
          title: 'Without saveLayer',
          painter: _WithoutSaveLayerPainter(opacity: opacity),
          codeFileName: 'opacity_without_save_layer',
        );
      },
    );
  }
}

class _WithSaveLayerPainter extends CustomPainter {
  const _WithSaveLayerPainter({
    required this.opacity,
  });

  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(
      Offset.zero & size,
      Paint()..color = Colors.transparent.withOpacity(opacity),
    );

    final tw = size.width / 6;
    final th = size.height / 6;

    final w = size.width * 2 / 3;
    final h = size.height * 2 / 3;

    void drawSquare(Color color) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, w, h),
        Paint()..color = color,
      );
    }

    drawSquare(FlutterColors.yellow);
    canvas.translate(tw, th);
    drawSquare(FlutterColors.red);
    canvas.translate(tw, th);
    drawSquare(FlutterColors.blue);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_WithSaveLayerPainter oldDelegate) {
    return oldDelegate.opacity != opacity;
  }
}

class _WithoutSaveLayerPainter extends CustomPainter {
  const _WithoutSaveLayerPainter({
    required this.opacity,
  });

  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final tw = size.width / 6;
    final th = size.height / 6;

    final w = size.width * 2 / 3;
    final h = size.height * 2 / 3;

    void drawSquare(Color color) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, w, h),
        Paint()..color = color.withOpacity(opacity),
      );
    }

    drawSquare(FlutterColors.yellow);
    canvas.translate(tw, th);
    drawSquare(FlutterColors.red);
    canvas.translate(tw, th);
    drawSquare(FlutterColors.blue);
  }

  @override
  bool shouldRepaint(_WithoutSaveLayerPainter oldDelegate) {
    return oldDelegate.opacity != opacity;
  }
}
