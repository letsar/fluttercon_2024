import 'dart:ui' as ui;

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';

class Speaker extends StatelessWidget {
  const Speaker({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return ImagePart(
      imagePath: 'assets/speakers.png',
      index: index,
    );
  }
}

class ImagePart extends StatefulWidget {
  const ImagePart({
    super.key,
    required this.index,
    required this.imagePath,
  });

  final int index;
  final String imagePath;

  @override
  State<ImagePart> createState() => _ImagePartState();
}

class _ImagePartState extends State<ImagePart> {
  ui.Image? image;

  @override
  void initState() {
    super.initState();
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
    image?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ImagePartPainter(
        image: image,
        index: widget.index,
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _ImagePartPainter extends CustomPainter {
  _ImagePartPainter({
    required this.image,
    required this.index,
  });

  final ui.Image? image;
  final int index;

  @override
  void paint(Canvas canvas, Size size) {
    if (image case final img?) {
      final src = Rect.fromLTWH(400.0 * index, 0, 400, 400);
      final rect = Alignment.center.inscribe(
        Size.square(size.shortestSide),
        Offset.zero & size,
      );
      canvas.drawImageRect(img, src, rect, Paint());
    }
  }

  @override
  bool shouldRepaint(_ImagePartPainter oldDelegate) {
    return oldDelegate.image != image || oldDelegate.index != index;
  }
}
