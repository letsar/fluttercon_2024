import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck_web_client/flutter_deck_web_client.dart';
import 'package:fluttercon_2024/slides/00_intro/slides.dart';
import 'package:fluttercon_2024/slides/01_face/slides.dart';
import 'package:fluttercon_2024/slides/02_mouth/slides.dart';
import 'package:fluttercon_2024/slides/03_eyes/slides.dart';
import 'package:fluttercon_2024/slides/04_sparkles/slides.dart';
import 'package:fluttercon_2024/slides/05_speakers/slides.dart';
import 'package:fluttercon_2024/slides/06_happy_sparkles_opacity/slides.dart';
import 'package:fluttercon_2024/slides/07_particles/slides.dart';
import 'package:fluttercon_2024/slides/08_outro/slides.dart';
import 'package:fluttercon_2024/utils/colors.dart';

void main() {
  runApp(const FlutterConDeck());
}

class FlutterConDeck extends StatelessWidget {
  const FlutterConDeck({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
      fontFamilyFallback: [
        'Apple Color Emoji',
      ],
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w400,
      fontFeatures: [
        FontFeature.enable('salt'),
        FontFeature.enable('ss02'),
        FontFeature.enable('ss05'),
        FontFeature.enable('ss08'),
        FontFeature.enable('ss09'),
        FontFeature.enable('ss11'),
      ],
    );
    final deckTheme = FlutterDeckThemeData(
      brightness: Brightness.dark,
      textTheme: FlutterDeckTextTheme(
        display: defaultTextStyle.copyWith(
          fontFamily: 'BigFont',
          fontSize: 120,
          letterSpacing: -1,
          wordSpacing: 10,
          fontWeight: FontWeight.bold,
        ),
        header: defaultTextStyle.copyWith(
          fontFamily: 'PP Neue Montreal',
          fontSize: 57,
        ),
        title: defaultTextStyle.copyWith(
          fontFamily: 'PP Neue Montreal',
          fontSize: 54,
        ),
        subtitle: defaultTextStyle.copyWith(
          fontFamily: 'PP Neue Montreal',
          fontSize: 42,
        ),
        bodyLarge: defaultTextStyle.copyWith(
          fontFamily: 'PP Neue Montreal',
          fontSize: 28,
        ),
        bodyMedium: defaultTextStyle.copyWith(
          fontFamily: 'PP Neue Montreal',
          fontSize: 22,
        ),
        bodySmall: defaultTextStyle.copyWith(
          fontFamily: 'PP Neue Montreal',
          fontSize: 16,
        ),
      ).apply(
        color: BrandColors.onSurface,
      ),
      theme: ThemeData.from(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: BrandColors.primary,
          onPrimary: BrandColors.onPrimary,
          secondary: BrandColors.secondary,
          onSecondary: BrandColors.onSecondary,
          surface: BrandColors.surface,
          onSurface: BrandColors.onSurface,
          background: BrandColors.surface,
          onBackground: BrandColors.onSurface,
          error: BrandColors.warning,
          onError: BrandColors.onWarning,
          tertiary: BrandColors.neutral,
          onTertiary: BrandColors.onNeutral,
        ),
        useMaterial3: true,
      ),
    ).copyWith(
      splitSlideTheme: const FlutterDeckSplitSlideThemeData(
        leftBackgroundColor: BrandColors.surface,
        leftColor: BrandColors.onSurface,
        rightBackgroundColor: BrandColors.secondary,
        rightColor: BrandColors.onSecondary,
      ),
    );

    return FlutterDeckApp(
      client: FlutterDeckWebClient(),
      speakerInfo: const FlutterDeckSpeakerInfo(
        name: 'Romain Rastel',
        description: 'Flutter Lead Developer',
        socialHandle: '@lets4r',
        imagePath: 'assets/speaker.jpg',
      ),
      configuration: FlutterDeckConfiguration(
        background: const FlutterDeckBackgroundConfiguration(
          light: FlutterDeckBackground.solid(BrandColors.surface),
          dark: FlutterDeckBackground.solid(BrandColors.surface),
        ),
        footer: const FlutterDeckFooterConfiguration(
          showSlideNumbers: true,
          showSocialHandle: true,
        ),
        header: const FlutterDeckHeaderConfiguration(
          showHeader: false,
          title: 'Enhance your Flutter painting skills',
        ),

        progressIndicator: const FlutterDeckProgressIndicator.solid(
          backgroundColor: BrandColors.progressBarSurface,
          color: BrandColors.onProgressBarSurface,
        ),
        // Use a custom slide size.
        slideSize: FlutterDeckSlideSize.fromAspectRatio(
          aspectRatio: const FlutterDeckAspectRatio.ratio16x9(),
          resolution: const FlutterDeckResolution.fhd(),
        ),
        // Use a custom transition between slides.
        transition: const FlutterDeckTransition.fade(),
      ),
      lightTheme: deckTheme,
      darkTheme: deckTheme,
      slides: const [
        ...IntroSlides.all,
        ...FaceSlides.all,
        ...MouthSlides.all,
        ...EyesSlides.all,
        ...SparklesSlides.all,
        ...SpeakersSlides.all,
        ...HappySparklesOpacitySlides.all,
        ...ParticlesSlides.all,
        ...OutroSlides.all,
      ],
      isPresenterView: kIsWeb,
    );
  }
}
