import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitleBuilder extends StatelessWidget {
  const CustomTitleBuilder({this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: GoogleFonts.aBeeZee(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
