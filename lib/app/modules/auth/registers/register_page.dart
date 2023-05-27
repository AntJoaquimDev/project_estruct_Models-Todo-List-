import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_Field.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Todo List',
                style: TextStyle(
                    fontSize: 10,
                    color: context.primaryColor,
                    fontWeight: FontWeight.bold)),
            Text('Cadastro',
                style: TextStyle(
                    fontSize: 10,
                    color: context.primaryColor,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        leading: ClipOval(
          child: Container(
            color: context.primaryColor.withAlpha(20),
            padding: const EdgeInsets.all(8),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_outlined),
            ),
          ),
        ),
      ),
      body: ListView(children: [
        Container(
          height: MediaQuery.of(context).size.width * .5,
          child: FittedBox(
            child: TodoListLogo(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Form(
            child: Column(
              children: [
                TodoListField(
                  label: 'E-mail',
                ),
                const SizedBox(height: 20),
                TodoListField(
                  label: 'Senha',
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                TodoListField(
                  label: 'Confirmar Senha',
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('Cadastar'),
                  ),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
