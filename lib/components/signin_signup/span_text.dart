import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSpanText extends StatelessWidget {
  const CustomSpanText({this.text, this.spanText, this.ontap});
  final String text;
  final String spanText;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: GoogleFonts.aBeeZee(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: ontap,
          child: Text(
            spanText,
            style: GoogleFonts.aBeeZee(
              fontSize: 19,
              color: Colors.blue.shade300,
            ),
          ),
        ),
      ],
    );
  }
}
