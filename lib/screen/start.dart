import 'package:flutter/material.dart';
import 'package:sale_tracker/screen/dashboard.dart';
import 'package:sale_tracker/screen/splash_screen.dart';

import 'login_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Widget? activeScreen;

  @override
  void initState() {
    activeScreen = SplashScreen(start:switchScreen);
    super.initState();
  }

  void loginLogic(){

  }

  void switchScreen() {
    setState(() {
      //activeScreen =  LoginScreen(loginLogic: loginLogic);
      //activeScreen =  const Expenses();
      //activeScreen =  const DashBoardScreen();
      activeScreen =  const LoginScreen();
    });
  }


  var kColorSchema = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 14, 14, 89),
  );

  var kDarkColorSchema = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 5, 99, 125),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
         // textTheme: GoogleFonts.latoTextTheme()
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
        //textTheme: GoogleFonts.latoTextTheme()
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorSchema.onSecondaryContainer,
              fontSize: 17),
        ),
      ),
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 220, 189, 252),
                  Color.fromARGB(225, 3, 7, 33)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: activeScreen),
      ),
    );
  }
}
