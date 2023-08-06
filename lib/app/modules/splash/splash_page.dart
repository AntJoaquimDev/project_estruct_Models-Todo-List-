import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_porvider.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';
import 'package:todo_list_provider/app/utils/todo_routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          TodoListLogo(),
          Center(
            child: TextButton(
                onPressed: () {
                  context.read<AuthPorvider>().logout();
                },
                child: const Text('Logout')),
          ),
        ],
      ),
    ));
  }
}
