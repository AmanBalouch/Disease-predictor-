import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart';
import 'output_screen.dart'; // Import your output screen
import '../constants/colors.dart';

class SplashScreen extends StatefulWidget {
  final String targetScreen;
  final String disease;
  final String confidence;

  const SplashScreen({Key? key, required this.targetScreen,required this.disease,required this.confidence}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // Decide delay and target screen
    Duration delay = widget.targetScreen == 'output_screen'
        ? Duration(seconds: 2)
        : Duration(seconds: 3);

    Timer(delay, () {
      if (widget.targetScreen == 'output_screen') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => output_screen(
              predictedDisease: widget.disease,
              predictionProbability: widget.confidence,
            ),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.local_hospital, size: 100, color: Colors.white),
              SizedBox(height: 20),
              Text(
                'Disease Predictor',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
