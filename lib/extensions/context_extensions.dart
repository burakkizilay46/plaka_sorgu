import 'package:flutter/material.dart';

extension ColorExtension on BuildContext {
  Color get appBlack => Colors.black;
  Color get appWhite => Colors.white;
}

extension TextStyleExtansion on BuildContext {
  TextStyle get normalTextStyle => const TextStyle(fontSize: 20, fontWeight: FontWeight.normal);

  TextStyle get bigTextStyle => const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
}

extension AppPaddings on BuildContext {
  EdgeInsets get appPadding => const EdgeInsets.all(16);
}
