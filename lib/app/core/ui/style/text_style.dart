import 'package:flutter/material.dart';

class TextStyles {
  static TextStyles? _inst;
  // Avoid self isntance
  TextStyles._();
  static TextStyles get inst {
    _inst ??= TextStyles._();
    return _inst!;
  }

  String get fontMplus1 => 'mplus1';
  String get fontTodoListIcons => 'TodoListIcons';

  TextStyles({required String fontFamily, required FontWeight fontWeight});

  TextStyle get textLight =>
      TextStyle(fontWeight: FontWeight.w300, fontFamily: fontMplus1);

  TextStyle get textRegular =>
      TextStyle(fontWeight: FontWeight.normal, fontFamily: fontMplus1);
  TextStyle get textTodoListIcons =>
      TextStyle(fontWeight: FontWeight.normal, fontFamily: fontTodoListIcons);

  TextStyle get textMedium =>
      TextStyle(fontWeight: FontWeight.w500, fontFamily: fontMplus1);

  TextStyle get textSemiBold =>
      TextStyle(fontWeight: FontWeight.w600, fontFamily: fontMplus1);

  TextStyle get textBold =>
      TextStyle(fontWeight: FontWeight.bold, fontFamily: fontMplus1);

  TextStyle get textExtraBold =>
      TextStyle(fontWeight: FontWeight.w800, fontFamily: fontMplus1);

  TextStyle get textButtonLabel => textBold.copyWith(fontSize: 14);

  TextStyle get textTitle => textExtraBold.copyWith(fontSize: 28);
}

extension TextStylesExtensions on BuildContext {
  TextStyles get textStyle => TextStyles.inst;
}
