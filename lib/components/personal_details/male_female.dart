import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaleFemale extends StatelessWidget {
  const MaleFemale({this.onPressFemale, this.onPressMale, this.selected});
  final Function onPressMale;
  final Function onPressFemale;
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: onPressMale,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selected == 0 ? Colors.grey : Colors.grey.shade900,
              ),
              child: Center(
                child: Text(
                  'Male',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 30,
                    color: selected == 0 ? Colors.black : Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: onPressFemale,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selected == 1 ? Colors.grey : Colors.grey.shade900,
              ),
              child: Center(
                child: Text(
                  'Female',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 30,
                    color: selected == 1 ? Colors.black : Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}