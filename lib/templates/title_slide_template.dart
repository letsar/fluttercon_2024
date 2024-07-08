import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/fitted_text.dart';
import 'package:fluttercon_2024/utils/stretched_column.dart';

class TitleSlideTemplate extends FlutterDeckSlideWidget {
  const TitleSlideTemplate({
    required super.configuration,
    required this.texts,
    this.widthFactor = 0.9,
  });

  final List<String> texts;
  final double widthFactor;

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return SizedBox.expand(
          child: StretchedColumn(
            widthFactor: widthFactor,
            children: texts.map((t) => FittedText(t)).toList(),
          ),
        );
      },
    );
  }
}
