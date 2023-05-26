import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 200,
          ),
          Text(
            'Todo List',
            style: context.textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
