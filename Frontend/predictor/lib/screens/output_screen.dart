import 'package:flutter/material.dart';
import 'package:predictor/screens/home_screen.dart';
import 'package:predictor/screens/splash_screen.dart';
import 'package:predictor/utils/ui_helper.dart';

import '../constants/colors.dart';

class output_screen extends StatelessWidget {
  final String predictedDisease;
  final String predictionProbability;

  const output_screen({
    Key? key,
    required this.predictedDisease,
    required this.predictionProbability,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: TextWidget(text: "Predicted result", size: 26, boldText: true, textColor: Colors.black),),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 4,
          color: AppColors.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: AppColors.primaryColor, // 👈 border color
              width: 3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Predicted Disease:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  predictedDisease,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  'Prediction Probability:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  predictionProbability,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen(targetScreen: "home_screen",disease: "",confidence: "")));
                  },
                  child: TextWidget(text: "Predict Again", size: 20, boldText: false, textColor: Colors.black),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
