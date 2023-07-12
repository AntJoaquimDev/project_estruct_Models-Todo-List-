import 'package:flutter/cupertino.dart';

class Validator {
  Validator._();

  static FormFieldValidator compare(
      TextEditingController? valueEC, String massage) {
    return (value) {
      final valueCompare = valueEC?.text ?? '';
      if (value == null || (value != null && value != valueCompare)) {
        return massage;
      }
    };
  }
}
