import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/utils/todo_routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spasg Page'),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(TodoRoutes.LOGIN);
            },
            child: Text('/P/login')),
      ),
    );
  }
}
