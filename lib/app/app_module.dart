import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/app-widget.dart';
import 'package:todo_list_provider/app/core/databse/sqlite_conector_factory.dart';

class AppModule extends StatelessWidget {
  const AppModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: ((_) => SqliteConectorFactory()),
          lazy: false,
        ),
      ],
      child: const AppWidget(),
    );
  }
}
/* {
      "name": "flutter",
      "rootUri": "file:///C:/Users/55869/fvm/versions/3.3.10/packages/flutter",
      "packageUri": "lib/",
      "languageVersion": "2.17"
    }, */