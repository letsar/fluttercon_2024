import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/colors.dart';
import 'package:fluttercon_2024/utils/fitted_text.dart';
import 'package:fluttercon_2024/utils/stretched_column.dart';

class QuoteSlide extends StatelessWidget {
  const QuoteSlide({
    super.key,
    required this.quote,
    required this.attribution,
  });

  final String quote;
  final String attribution;

  @override
  Widget build(BuildContext context) {
    final effectiveQuote = '“ $quote ”';
    final lines = effectiveQuote.split('\n');

    const widthFactor = 0.9;
    return FlutterDeckSlide.custom(builder: (context) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StretchedColumn(
              widthFactor: widthFactor,
              children: lines.map((line) {
                return FittedText(line, color: BrandColors.warning);
              }).toList(),
            ),
            const SizedBox(height: 32),
            FractionallySizedBox(
              widthFactor: widthFactor,
              child: Container(
                height: 4,
                width: double.infinity,
                color: BrandColors.light,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              attribution,
              style: FlutterDeckTheme.of(context).textTheme.title.copyWith(
                    color: BrandColors.light,
                  ),
            ),
          ],
        ),
      );
    });
  }
}
