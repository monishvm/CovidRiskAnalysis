import 'package:covid/components/signin_signup/title_builder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeightWeight extends StatelessWidget {
  const HeightWeight({this.onchange, this.hintText, this.extention});
  final Function onchange;
  final String hintText;
  final String extention;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: CustomTitleBuilder(
            text: hintText,
          ),
        ),
        Container(
          width: 100,
          child: TextField(
            maxLength: 5,
            keyboardType: TextInputType.number,
            onChanged: onchange,
            cursorColor: Colors.black,
            style: GoogleFonts.firaSans(fontSize: 18.2),
            cursorHeight: 20,
            textInputAction: TextInputAction.continueAction,
            obscureText: false,
            decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.grey.shade300,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        CustomTitleBuilder(
          text: extention,
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
