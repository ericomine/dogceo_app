import 'dart:io';

import 'package:flutter/material.dart';

class ThemeBuilder {
  static final primaryColor = Colors.orange;
  static final auxTextColor = Colors.amber;
  static final backgroundColor = Colors.orange[50];

  static ThemeData build() {
    Map<String, double> fontSizes = (Platform.isAndroid || Platform.isIOS)
        ? {"h6": 25.0, "b1": 18.0, "b2": 16.0}
        : {"h6": 16.0, "b1": 13.0, "b2": 10.5};

    final base = ThemeData.light();
    return base.copyWith(
      primaryColor: primaryColor,
      backgroundColor: backgroundColor,
      textTheme: base.textTheme
          .copyWith(
            headline6: TextStyle(
                fontSize: fontSizes["h6"],
                fontWeight: FontWeight.w800,
                color: primaryColor),
            bodyText1: TextStyle(
                fontSize: fontSizes["b1"],
                fontWeight: FontWeight.w800,
                color: primaryColor),
            bodyText2: TextStyle(
                fontSize: fontSizes["b2"],
                fontWeight: FontWeight.w500,
                color: auxTextColor),
          )
          .apply(
            fontFamily: "Montserrat",
          ),
    );
  }
}
