import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_list_provider/app/core/databse/sqlite_adm_conection.dart';
import 'package:todo_list_provider/app/core/navigator/todo_list_navigator.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_theme_config.dart';
import 'package:todo_list_provider/app/modules/auth/auth_module.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_module.dart';
import 'package:todo_list_provider/app/modules/tasks/task_module.dart';

import 'modules/splash/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteAdmConection = SqliteAdmConection();
  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    WidgetsBinding.instance
        .addObserver(sqliteAdmConection); // The Error is right here
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqliteAdmConection);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List Provider',
      theme: TodoListThemeConfig.theme,
      navigatorKey: TodoListNavigator.navigatorKey,
      //initialRoute: TodoRoutes.LOGIN,

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        // Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
      routes: {
        ...AuthModule().routrs,
        ...HomeModule().routrs,
        ...TaskModule().routrs,
      },
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
