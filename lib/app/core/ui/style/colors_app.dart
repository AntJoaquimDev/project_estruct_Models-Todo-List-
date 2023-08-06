import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _inst;
  ColorsApp._();

  static ColorsApp get inst {
    _inst ??= ColorsApp._();
    return _inst!;
  }

  Color get primary => Color.fromARGB(255, 47, 77, 197);
  Color get secundary => Color.fromARGB(255, 35, 97, 136);
  Color get primaryLight => const Color(0XFFD2FFBC);
  Color get Grey => const Color(0XFF9b9898);
  Color get Scaffold1 => const Color(0XFFFAFBFE);
  Color get colorIcon => const Color(0XFFFFFFff);
}

extension ColorsAppExtension on BuildContext {
  ColorsApp get colors => ColorsApp.inst;
}
