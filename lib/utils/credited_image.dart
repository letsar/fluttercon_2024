import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:fluttercon_2024/utils/colors.dart';

class CreditedImage extends StatelessWidget {
  const CreditedImage({
    super.key,
    required this.image,
    required this.credits,
  });

  final String image;
  final String credits;

  @override
  Widget build(BuildContext context) {
    final textStyle = FlutterDeckTheme.of(context).textTheme.header.copyWith(
          color: BrandColors.light,
        );

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/$image',
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: BrandColors.dark.withOpacity(0.5),
            padding: const EdgeInsets.all(8),
            child: Text(
              credits,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
