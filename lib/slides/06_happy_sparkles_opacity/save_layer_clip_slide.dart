import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/custom_paint_pane.dart';

const _speakerNotes = '''
This is another example where saveLayer comes to the rescue.

Here we apply a non-rectangular anti-aliased clip to the canvas.

Without saveLayer, the drawing is anti-aliased with the background first, and then it is anti-aliased with this result.
On the other hand, with saveLayer, the second drawing covers the first one and the clip is apply to the result of this layer.

Let's look at the code:
''';

class SaveLayerClipSlide extends FlutterDeckSlideWidget {
  const SaveLayerClipSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/save-layer-clip',
            title: 'Canvas.saveLayer Clip',
            steps: 2,
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
            header: FlutterDeckHeaderConfiguration(title: 'Clip effect'),
            hidden: true,
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) {
        return const _WithoutSaveLayer();
      },
      rightBuilder: (context) {
        return const _WithSaveLayer();
      },
    );
  }
}

class _AntiAliasBuilder extends StatefulWidget {
  const _AntiAliasBuilder({
    required this.builder,
  });

  final Widget Function(BuildContext, Widget, bool) builder;

  @override
  State<_AntiAliasBuilder> createState() => _AntiAliasBuilderState();
}

class _AntiAliasBuilderState extends State<_AntiAliasBuilder> {
  bool antiAlias = true;

  @override
  Widget build(BuildContext context) {
    final checkBox = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Use anti alias:',
          style: FlutterDeckTheme.of(context).textTheme.bodyLarge,
        ),
        Checkbox(
          value: antiAlias,
          onChanged: (value) {
            setState(() {
              antiAlias = value!;
            });
          },
        ),
      ],
    );
    return widget.builder(context, checkBox, antiAlias);
  }
}

class _WithSaveLayer extends StatelessWidget {
  const _WithSaveLayer();

  @override
  Widget build(BuildContext context) {
    return _AntiAliasBuilder(builder: (context, checkBox, antiAlias) {
      return FlutterDeckSlideStepsBuilder(
        builder: (context, step) {
          return CustomPaintPane(
            step: step - 1,
            title: 'With saveLayer',
            subtitle: checkBox,
            painter: _WithSaveLayerPainter(antiAlias: antiAlias),
            codeFileName: 'clip_with_save_layer',
          );
        },
      );
    });
  }
}

class _WithoutSaveLayer extends StatelessWidget {
  const _WithoutSaveLayer();

  @override
  Widget build(BuildContext context) {
    return _AntiAliasBuilder(builder: (context, checkbox, antiAlias) {
      return FlutterDeckSlideStepsBuilder(
        builder: (context, step) {
          return CustomPaintPane(
            step: step - 1,
            title: 'Without saveLayer',
            subtitle: checkbox,
            painter: _WithoutSaveLayerPainter(antiAlias: antiAlias),
            codeFileName: 'clip_without_save_layer',
          );
        },
      );
    });
  }
}

class _WithSaveLayerPainter extends CustomPainter {
  const _WithSaveLayerPainter({
    required this.antiAlias,
  });

  final bool antiAlias;

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    canvas.save();
    canvas.clipRRect(
      RRect.fromRectXY(rect, 100.0, 100.0),
      doAntiAlias: antiAlias,
    );
    canvas.saveLayer(rect, Paint());
    canvas.drawPaint(Paint()..color = Colors.red);
    canvas.drawPaint(Paint()..color = Colors.white);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _WithoutSaveLayerPainter extends CustomPainter {
  const _WithoutSaveLayerPainter({
    required this.antiAlias,
  });

  final bool antiAlias;

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    canvas.save();
    canvas.clipRRect(
      RRect.fromRectXY(rect, 100.0, 100.0),
      doAntiAlias: antiAlias,
    );
    canvas.drawPaint(Paint()..color = Colors.red);
    canvas.drawPaint(Paint()..color = Colors.white);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
