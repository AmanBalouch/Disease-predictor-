import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'constants/colors.dart';

void main() {
  runApp(DiseasePredictorApp());
}

class DiseasePredictorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disease Predictor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        fontFamily: 'Roboto',
      ),
      home: SplashScreen(targetScreen: "home_screen",disease: "",confidence: ""),
    );
  }
}
