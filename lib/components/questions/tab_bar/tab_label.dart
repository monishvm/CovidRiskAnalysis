import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  CustomTab({this.label});

  final String label;
  @override
  Widget build(BuildContext context) {
    return Tab(
      iconMargin: EdgeInsets.all(0),
      child: Center(child: Text(label)),
    );
  }
}
