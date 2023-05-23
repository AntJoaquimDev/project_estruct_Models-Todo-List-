import 'package:flutter/cupertino.dart';
import 'package:todo_list_provider/app/core/databse/sqlite_conector_factory.dart';

class SqliteAdmConection with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final conection = SqliteConectorFactory();
    switch (state) {
      case AppLifecycleState.resumed:
        break;

      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        conection.closeconection();
        break;
    }

    super.didChangeAppLifecycleState(state);
  }
}
