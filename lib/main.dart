import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_tracker/screen/splash_screen.dart';
import 'package:sale_tracker/screen/start.dart';

var kColorSchema = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 14, 14, 89),
);

var kDarkColorSchema = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]).then((fn) {
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorSchema,
          brightness: Brightness.dark,
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorSchema.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kDarkColorSchema.primaryContainer,
                foregroundColor: kDarkColorSchema.onPrimaryContainer
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kDarkColorSchema.onSecondaryContainer,
                fontSize: 17),
          ),
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorSchema,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorSchema.onPrimaryContainer,
            foregroundColor: kColorSchema.primaryContainer,
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 220, 189, 252),
          cardTheme: const CardTheme().copyWith(
            color: kColorSchema.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorSchema.primaryContainer),
          ),
          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorSchema.onSecondaryContainer,
                fontSize: 17),
          ),
        ),
        home: const StartScreen(),
      ),
    );
  });

}
