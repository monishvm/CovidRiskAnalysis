import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton({this.text, this.ontap});
  final String text;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 70,
        decoration: BoxDecoration(
          color: Colors.blue.shade600,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.aBeeZee(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}