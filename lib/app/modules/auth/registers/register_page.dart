// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/core/widgets/bottun_clip_oval.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_Field.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/registers/register_controller.dart';
import 'package:todo_list_provider/app/validators/validator.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emaiEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    final defaultListener = DefaultListenerNotifier(
        changeNotifier: context.read<RegisterController>());
    defaultListener.Listener(
      context: context,
      successVoidCalback: (notifier, listenerInstace) {
        listenerInstace.dispose();
        Navigator.of(context).pop();
      },
      erroVoidCalback: (notifier, listenerInstace) => print('deu ruim'),
    );

    // context.read<RegisterController>().addListener(() {
    //   final controller = context.read<RegisterController>();
    //   var success = controller.success;
    //   var error = controller.error;
    //   if (success==true) {
    //     Navigator.of(context).pop();
    //   } else if (error != null && error.isNotEmpty) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(error),
    //         backgroundColor: Colors.red,
    //       ),
    //     );
    //   }
    // });
  }

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
        leading: BottunClipOval(),
      ),
      body: ListView(children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * .5,
          child: const FittedBox(
            child: TodoListLogo(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TodoListField(
                  controller: _emaiEC,
                  label: 'E-mail',
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail obrigatório.'),
                    Validatorless.email('E-mail inválido.'),
                  ]),
                ),
                const SizedBox(height: 20),
                TodoListField(
                  controller: _passwordEC,
                  label: 'Senha',
                  obscureText: true,
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha obrigatório.'),
                    Validatorless.min(
                        6, 'Senha deve conter pelo menos 6 digitos.'),
                  ]),
                ),
                const SizedBox(height: 20),
                TodoListField(
                  controller: _confirmPasswordEC,
                  label: 'Confirmar Senha',
                  obscureText: true,
                  validator: Validatorless.multiple([
                    Validatorless.required('Confirma Senha obrigatória.'),
                    Validator.compare(_passwordEC, 'Senha diferente de senha')
                  ]),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        final email = _emaiEC.text;
                        final password = _passwordEC.text;
                        context
                            .read<RegisterController>()
                            .registerUser(email, password);
                      }
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Cadastar'),
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
