import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class AnimatedVerticalCarousel extends ImplicitlyAnimatedWidget {
  const AnimatedVerticalCarousel({
    super.key,
    super.curve = Curves.linear,
    super.duration = const Duration(milliseconds: 300),
    this.fitHeight,
    required this.step,
    required this.children,
  });

  final int step;
  final bool? fitHeight;
  final List<Widget> children;

  @override
  ImplicitlyAnimatedWidgetState<AnimatedVerticalCarousel> createState() =>
      _AnimatedVerticalCarouselState();
}

class _AnimatedVerticalCarouselState
    extends AnimatedWidgetBaseState<AnimatedVerticalCarousel> {
  Tween<double>? _progress;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _progress = visitor(
      _progress,
      widget.step.toDouble(),
      (dynamic value) => Tween<double>(
        begin: value as double,
      ),
    ) as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    final progress = _progress?.evaluate(animation) ?? 0;

    return ClipRect(
      child: VerticalCarousel(
        progress: progress,
        fitHeight: widget.fitHeight,
        children: widget.children,
      ),
    );
  }
}

class VerticalCarousel extends MultiChildRenderObjectWidget {
  const VerticalCarousel({
    super.key,
    required this.progress,
    this.fitHeight = false,
    required super.children,
  });

  final double progress;
  final bool? fitHeight;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderVerticalCarousel(
      progress: progress,
      fitHeight: fitHeight ?? false,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderVerticalCarousel renderObject,
  ) {
    renderObject
      ..progress = progress
      ..fitHeight = fitHeight ?? false;
  }
}

class _OnboardingCarouselParentData extends ContainerBoxParentData<RenderBox> {
  final layerHandle = LayerHandle<OpacityLayer>();

  @override
  detach() {
    layerHandle.layer = null;
    super.detach();
  }
}

class _RenderVerticalCarousel extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _OnboardingCarouselParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox,
            _OnboardingCarouselParentData> {
  _RenderVerticalCarousel({
    List<RenderBox>? children,
    required double progress,
    required bool fitHeight,
  })  : _progress = progress,
        _fitHeight = fitHeight {
    addAll(children);
  }

  double get progress => _progress;
  double _progress;
  set progress(double value) {
    if (_progress == value) {
      return;
    }
    _progress = value;
    markNeedsPaint();
  }

  bool get fitHeight => _fitHeight;
  bool _fitHeight;
  set fitHeight(bool value) {
    if (_fitHeight == value) {
      return;
    }
    _fitHeight = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _OnboardingCarouselParentData) {
      child.parentData = _OnboardingCarouselParentData();
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: constraints.minHeight,
      maxHeight: constraints.maxHeight,
    ).biggest;
  }

  final List<double> _childOffsets = [];

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
    _childOffsets.clear();
    final maxHeight = constraints.maxHeight;
    final childConstraints = BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: fitHeight ? maxHeight : constraints.minHeight,
      maxHeight: maxHeight,
    );
    RenderBox? child = firstChild;
    double offset = 0;
    while (child != null) {
      final childParentData = child.parentData as _OnboardingCarouselParentData;
      child.layout(childConstraints, parentUsesSize: true);
      final delta = (maxHeight - child.size.height) / 2;
      if (fitHeight) {
        offset += delta;
      }
      _childOffsets.add(offset);
      childParentData.offset = Offset(0, offset);
      offset += child.size.height;
      if (fitHeight) {
        offset += delta;
      }

      child = childParentData.nextSibling;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final effectiveProgress = _progress.clamp(0, _childOffsets.length - 1);
    final upperBound = effectiveProgress.ceil();
    final lowerBound = effectiveProgress.floor();
    final t = effectiveProgress - lowerBound.toDouble();
    final upperOffset = _childOffsets[upperBound];
    final lowerOffset = _childOffsets[lowerBound];
    final delta = Offset(0, lerpDouble(lowerOffset, upperOffset, t) ?? 0);

    RenderBox? child = firstChild;
    int index = 0;
    while (child != null) {
      final opacity =
          (1.0 - (effectiveProgress - index).abs()).clamp(0.12, 1.0);
      final alpha = Color.getAlphaFromOpacity(opacity);
      final color = Color.fromARGB(alpha, 0, 0, 0);

      final childParentData = child.parentData as _OnboardingCarouselParentData;
      final childOffset = childParentData.offset + offset - delta;
      context.canvas.saveLayer(
        childOffset & child.size,
        Paint()..color = color,
      );
      context.paintChild(child, childOffset);
      context.canvas.restore();
      child = childParentData.nextSibling;
      index++;
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    int index = _childOffsets.length - 1;
    final effectiveProgress = _progress.clamp(0, index).ceil();

    RenderBox? child = lastChild;
    while (child != null) {
      final childParentData =
          child.parentData! as _OnboardingCarouselParentData;
      if (index == effectiveProgress) {
        // The x, y parameters have the top left of the node's box as the origin.

        final upperBound = effectiveProgress.ceil();
        final lowerBound = effectiveProgress.floor();
        final t = effectiveProgress - lowerBound.toDouble();
        final upperOffset = _childOffsets[upperBound];
        final lowerOffset = _childOffsets[lowerBound];
        final delta = Offset(0, lerpDouble(lowerOffset, upperOffset, t) ?? 0);

        final bool isHit = result.addWithPaintOffset(
          offset: childParentData.offset - delta,
          position: position,
          hitTest: (BoxHitTestResult result, Offset transformed) {
            return child!.hitTest(result, position: transformed);
          },
        );
        if (isHit) {
          return true;
        }
      }
      child = childParentData.previousSibling;
      index--;
    }
    return false;
  }
}
