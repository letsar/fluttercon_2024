import 'package:flutter/widgets.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class PaintedImage extends StatelessWidget {
  const PaintedImage({
    super.key,
    required this.path,
    this.opacity = 1.0,
    this.fit = BoxFit.contain,
  });

  final String path;
  final double opacity;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return PaintedEffect(
      opacity: opacity,
      child: Image.asset(
        path,
        fit: BoxFit.contain,
      ),
    );
  }
}

class PaintedEffect extends StatelessWidget {
  const PaintedEffect({
    super.key,
    this.opacity = 1.0,
    required this.child,
  });

  final double opacity;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Opacity(
        opacity: opacity,
        child: ShaderBuilder(
          assetKey: 'shaders/oil_painting.frag',
          (context, shader, child) {
            return AnimatedSampler(
              (image, size, canvas) {
                shader.setFloatUniforms(
                  (uniforms) {
                    shader.setFloatUniforms((uniforms) {
                      uniforms.setSize(size);
                    });
                  },
                );

                shader.setImageSampler(0, image);

                canvas.drawRect(
                  Rect.fromLTWH(0, 0, size.width, size.height),
                  Paint()..shader = shader,
                );
              },
              child: child!,
            );
          },
          child: child,
        ),
      ),
    );
  }
}
