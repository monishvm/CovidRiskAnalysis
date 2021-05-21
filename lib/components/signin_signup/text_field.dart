import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({this.hint, this.onChange, this.inVisible});
  final String hint;
  final Function onChange;
  final bool inVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: TextField(
        onChanged: onChange,
        cursorColor: Colors.black,
        style: GoogleFonts.firaSans(fontSize: 18.2),
        cursorHeight: 20,
        textInputAction: TextInputAction.next,
        obscureText: inVisible,
        decoration: InputDecoration(
          hintText: hint,
          fillColor: Colors.grey.shade300,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
