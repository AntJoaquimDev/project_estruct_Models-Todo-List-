import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/databse/sqlite_adm_conection.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_theme_config.dart';
import 'package:todo_list_provider/app/modules/auth/auth_module.dart';
import 'package:todo_list_provider/app/utils/todo_routes.dart';

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
      initialRoute: TodoRoutes.LOGIN,
      routes: {
        ...AuthModule().routrs,
      },
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
