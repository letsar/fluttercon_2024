import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/colors.dart';

class FittedText extends StatelessWidget {
  const FittedText(
    this.text, {
    super.key,
    this.color,
    this.horizontalPadding,
    this.enableFit,
  });

  final String text;
  final Color? color;
  final double? horizontalPadding;
  final bool? enableFit;

  @override
  Widget build(BuildContext context) {
    final deckTheme = FlutterDeckTheme.of(context);
    final textStyle = deckTheme.textTheme.display.copyWith(
      height: 0.9,
      shadows: [
        const Shadow(
          color: DeckColors.eerieBlack,
          offset: Offset(8, 8),
          blurRadius: 8,
        ),
      ],
    );

    final effectiveColor = color ?? BrandColors.onNeutral;
    final slideSize =
        FlutterDeck.of(context).globalConfiguration.slideSize.width ?? 0;

    final effectiveHorizontalPadding =
        horizontalPadding ?? (text.length == 1 ? (slideSize / 1920) * 160 : 0);

    Widget result = Text(
      text.toUpperCase(),
      style: textStyle.copyWith(color: effectiveColor),
      textAlign: TextAlign.center,
    );

    if (enableFit ?? true) {
      result = FittedBox(
        child: result,
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: effectiveHorizontalPadding),
      child: result,
    );
  }
}

class RowFittedText extends StatelessWidget {
  const RowFittedText({
    super.key,
    required this.children,
  });

  final List<FittedText> children;

  @override
  Widget build(BuildContext context) {
    final deckTheme = FlutterDeckTheme.of(context);
    final textStyle = deckTheme.textTheme.display.copyWith(
      height: 0.9,
      shadows: [
        const Shadow(
          color: DeckColors.eerieBlack,
          offset: Offset(8, 8),
          blurRadius: 8,
        ),
      ],
    );

    return FittedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: children.map(
          (e) {
            final effectiveColor = e.color ?? BrandColors.onNeutral;

            return Text(
              e.text.toUpperCase(),
              style: textStyle.copyWith(color: effectiveColor),
              textAlign: TextAlign.left,
            );
          },
        ).toList(),
      ),
    );
  }
}
