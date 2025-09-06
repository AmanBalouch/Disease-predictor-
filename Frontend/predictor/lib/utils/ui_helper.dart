import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class UIHelper {
  static InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}

class TextWidget extends StatelessWidget {
  final String text;
  final double size;
  final bool? boldText;
  final Color textColor;

  TextWidget(
      {required this.text, required this.size, required this.boldText, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        color: textColor,
        fontSize: size,
        fontWeight: (boldText ?? false) ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
