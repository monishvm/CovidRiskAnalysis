import 'package:covid/components/signin_signup/title_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Age extends StatelessWidget {
  const Age({this.onchange});
  final Function onchange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTitleBuilder(
          text: 'Age',
        ),
        Container(
          height: 110,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(20),
          ),
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: 17),
            looping: true,
            itemExtent: 50,
            onSelectedItemChanged: onchange,
            children: List.generate(
              100,
              (index) => Text(
                '${index + 1}',
                style: GoogleFonts.aBeeZee(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
