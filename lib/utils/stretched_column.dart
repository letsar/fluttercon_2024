import 'package:flutter/widgets.dart';

class StretchedColumn extends StatelessWidget {
  const StretchedColumn({
    super.key,
    required this.widthFactor,
    this.alignment,
    required this.children,
  });

  final double widthFactor;
  final AlignmentGeometry? alignment;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      alignment: alignment ?? Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
